{ pkgs, lib }:

{
  url,
  archiveHash,
  packHash ? lib.fakeHash,
  side ? "server",
  pname ? "modrinth-pack",
  version ? "",
  ...
}@args:

let
  modpackArchive = pkgs.fetchurl {
    inherit url;
    hash = args.archiveHash;
  };

  fixedSource = pkgs.runCommand "modrinth-modpack-source" {
    nativeBuildInputs = [ pkgs.unzip ];
  } ''
    mkdir -p "$out"
    unzip -q ${modpackArchive} -d "$out"

    # Some .mrpack haven't read permissions set on the files, which causes issues when unpacking them.
    find "$out" -type d -exec chmod 755 {} +
    find "$out" -type f -exec chmod 644 {} +
  '';

in
  pkgs.fetchModrinthModpack ({
    src = fixedSource;
    inherit packHash side pname version;
  } // builtins.removeAttrs args [
    "url"
    "archiveHash"
    "packHash"
    "side"
    "pname"
    "version"
  ])
