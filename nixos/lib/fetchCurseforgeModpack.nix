
# lib/fetchCurseforgeModpack.nix
{ pkgs, lib }:

{
  lockFile,
  pname ? "curseforge-modpack",
  version ? "1",
}:

let
  lock = builtins.fromJSON (builtins.readFile lockFile);

  pack = pkgs.fetchurl {
    name = lock.pack.fileName;
    url = lock.pack.url;
    sha1 = lock.pack.sha1;
  };

  requiredFiles = builtins.filter
    (file: file.required or true)
    lock.files;

  downloads = map
    (file: {
      inherit file;
      drv = pkgs.fetchurl {
        name = file.fileName;
        url = file.url;
        sha1 = file.sha1;
      };
    })
    requiredFiles;

  installMods = lib.concatMapStringsSep "\n"
    (item: ''
      install -m 0644 ${item.drv} \
        "$out/mods/"${lib.escapeShellArg item.file.fileName}
    '')
    downloads;

in
pkgs.runCommand "${pname}-${version}" {
  nativeBuildInputs = [ pkgs.unzip ];

  passthru = {
    inherit (lock) manifest;
    inherit lock;
  };
} ''
  set -euo pipefail

  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT

  mkdir -p "$out"

  unzip -q ${pack} -d "$tmp"

  # Normalizar permisos del contenido extraído.
  # Algunos ZIP de CurseForge incluyen archivos sin permiso de lectura.
  chmod -R u+rwX,go+rX "$tmp"

  # Instalar los archivos de overrides, incluyendo config y scripts.
  if [ -d "$tmp/overrides" ]; then
    cp -R "$tmp/overrides/." "$out/"
  fi

  # Descargar los mods fijados en el lock.
  mkdir -p "$out/mods"

  ${installMods}

  # Mantener el manifest disponible para inspección.
  install -m 0644 "$tmp/manifest.json" "$out/manifest.json"
''
