#!/usr/bin/env python3

import argparse
import hashlib
import json
import os
import sys
import tempfile
import urllib.error
import urllib.request
import zipfile

from pathlib import Path
from urllib.parse import urlparse


API_BASE = "https://api.curseforge.com/v1"


def read_api_key(value):
    if value:
        path = Path(value).expanduser()

        if path.is_file():
            value = path.read_text(encoding="utf-8").strip()

        return value.strip()

    value = os.environ.get("CURSEFORGE_API_KEY", "").strip()

    if not value:
        raise RuntimeError(
            "Falta la API key. Usa --api-key o CURSEFORGE_API_KEY."
        )

    return value


def request_json(url, api_key, data=None):
    headers = {
        "Accept": "application/json",
        "x-api-key": api_key,
    }

    body = None

    if data is not None:
        headers["Content-Type"] = "application/json"
        body = json.dumps(data).encode("utf-8")

    request = urllib.request.Request(
        url,
        data=body,
        headers=headers,
        method="POST" if body is not None else "GET",
    )

    try:
        with urllib.request.urlopen(request, timeout=60) as response:
            return json.load(response)
    except urllib.error.HTTPError as error:
        raise RuntimeError(
            f"CurseForge API respondió HTTP {error.code} para "
            f"{urlparse(url).path}"
        ) from None
    except urllib.error.URLError as error:
        raise RuntimeError(
            f"No se pudo conectar con CurseForge: {error.reason}"
        ) from None


def get_file(mod_id, file_id, api_key):
    response = request_json(
        f"{API_BASE}/mods/{mod_id}/files/{file_id}",
        api_key,
    )

    result = response.get("data")

    if not result:
        raise RuntimeError(
            f"No se encontraron metadatos para {mod_id}/{file_id}"
        )

    return result


def get_sha1(file_data):
    for item in file_data.get("hashes", []):
        if item.get("algo") == 1:
            return item["value"].lower()

    raise RuntimeError(
        f"No hay hash SHA-1 disponible para "
        f"{file_data.get('fileName', file_data.get('id'))}"
    )


def get_download_url(mod_id, file_id, file_data, api_key):
    url = file_data.get("downloadUrl")

    if url:
        return url

    response = request_json(
        f"{API_BASE}/mods/{mod_id}/files/{file_id}/download-url",
        api_key,
    )

    url = response.get("data")

    if not url:
        raise RuntimeError(
            f"El archivo {mod_id}/{file_id} no tiene URL de descarga. "
            "Puede no estar disponible para distribución mediante la API."
        )

    return url


def download_to(url, destination):
    request = urllib.request.Request(
        url,
        headers={"User-Agent": "nixos-curseforge-prefetch/1.0"},
    )

    with urllib.request.urlopen(request, timeout=120) as response:
        with open(destination, "wb") as output:
            while chunk := response.read(1024 * 1024):
                output.write(chunk)


def prefetch(mod_id, file_id, api_key, output, ignore_download_url=False):
    print(f"Consultando modpack {mod_id}/{file_id}...", file=sys.stderr)

    pack_data = get_file(mod_id, file_id, api_key)

    pack_url = get_download_url(
        mod_id, file_id, pack_data, api_key
    )

    pack_sha1 = get_sha1(pack_data)

    with tempfile.TemporaryDirectory(prefix="curseforge-prefetch-") as tmp:
        archive_path = Path(tmp) / "modpack.zip"

        print("Descargando temporalmente el modpack...", file=sys.stderr)
        download_to(pack_url, archive_path)

        actual_sha1 = hashlib.sha1(archive_path.read_bytes()).hexdigest()

        if actual_sha1 != pack_sha1:
            raise RuntimeError(
                "El SHA-1 del ZIP descargado no coincide con el de la API."
            )

        try:
            with zipfile.ZipFile(archive_path) as archive:
                manifest = json.loads(
                    archive.read("manifest.json").decode("utf-8")
                )
        except (KeyError, zipfile.BadZipFile, json.JSONDecodeError) as error:
            raise RuntimeError(
                f"El ZIP no contiene un manifest.json válido: {error}"
            ) from None

        manifest_files = manifest.get("files", [])
        required_files = [
            item for item in manifest_files
            if item.get("required", True)
        ]

        # El endpoint batch evita una petición individual por cada mod.
        resolved = {}

        for start in range(0, len(required_files), 50):
            batch = required_files[start:start + 50]
            file_ids = [item["fileID"] for item in batch]

            response = request_json(
                f"{API_BASE}/mods/files",
                api_key,
                {"fileIds": file_ids},
            )

            for item in response.get("data", []):
                resolved[(item["modId"], item["id"])] = item

        files = []

        for index, item in enumerate(required_files, start=1):
            project_id = item["projectID"]
            file_id = item["fileID"]
            key = (project_id, file_id)

            file_data = resolved.get(key)

            if file_data is None:
                raise RuntimeError(
                    f"CurseForge no devolvió el archivo "
                    f"{project_id}/{file_id}. Comprueba que siga disponible."
                )

            filename = Path(file_data["fileName"]).name

            if filename in ("", ".", ".."):
                raise RuntimeError(
                    f"Nombre de archivo no válido para {project_id}/{file_id}"
                )

            try:
                url = get_download_url(
                    project_id,
                    file_id,
                    file_data,
                    api_key,
                )
            except RuntimeError as error:
                if not ignore_download_url:
                    raise

                print(
                    f"WARNING: se omite {filename} "
                    f"(projectId={project_id}, fileId={file_id}): "
                    f"{error}",
                    file=sys.stderr,
                )
                continue

            files.append({
                "projectId": project_id,
                "fileId": file_id,
                "fileName": filename,
                "url": url,
                "sha1": get_sha1(file_data),
                "required": True,
            })

            print(
                f"[{index}/{len(required_files)}] {filename}",
                file=sys.stderr,
            )

        result = {
            "format": 1,
            "pack": {
                "url": pack_url,
                "fileName": pack_data["fileName"],
                "sha1": pack_sha1,
            },
            "manifest": manifest,
            "files": files,
        }

        output = Path(output)
        output.parent.mkdir(parents=True, exist_ok=True)

        output.write_text(
            json.dumps(result, indent=2, ensure_ascii=False) + "\n",
            encoding="utf-8",
        )

        print(f"Prefetch guardado en {output}", file=sys.stderr)


def main():
    parser = argparse.ArgumentParser(
        description="Genera un lock JSON para un modpack de CurseForge."
    )
    parser.add_argument(
        "--api-key",
        help="API key literal o ruta a un archivo que la contenga.",
    )
    parser.add_argument("--mod-id", type=int, required=True)
    parser.add_argument("--file-id", type=int, required=True)
    parser.add_argument("--output", required=True)
    parser.add_argument(
        "--ignore-download-url",
        action="store_true",
        help=(
            "Omite con un warning los mods cuya URL de descarga "
            "no se pueda obtener."
        ),
    )

    args = parser.parse_args()

    try:
        api_key = read_api_key(args.api_key)
        prefetch(
            args.mod_id,
            args.file_id,
            api_key,
            args.output,
            ignore_download_url=args.ignore_download_url,
        )
    except (RuntimeError, OSError, ValueError, KeyError) as error:
        print(f"Error: {error}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
