{ pkgs, lib, ... }:
let 
  fetchModrinthModpackFixed = import ../../lib/fetchModrinthModpack.nix { 
    inherit pkgs lib; 
  };
  
  modpack = fetchModrinthModpackFixed {
    url = "https://cdn.modrinth.com/data/Jkb29YJU/versions/4SKGla61/COBBLEVERSE%201.7.42.mrpack";
    archiveHash = "sha256-3K8BBix8OH4O0HIJqrmT4uOycRHnePWDLFJVjSi8zYg=";
    packHash = "sha256-Om+mTbrgyJDsJhA0FM/CJ5ph3Lxh6fec9UFIaxQ1P/o=";
    side = "server";
  };
  mcVersion = modpack.manifest.dependencies.minecraft;
  fabricVersion = modpack.manifest.dependencies.fabric-loader;
  # serverVersion = lib.replaceStrings [ "." ] [ "_" ] "fabric-${mcVersion}";
  serverVersion = "fabric-${lib.replaceStrings [ "." ] [ "_" ] mcVersion}";
in
{
  services.minecraft-servers.servers.cobbleverse = {
    enable = true;
    autoStart = false;

    package = pkgs.fabricServers.${serverVersion}.override { 
      loaderVersion = fabricVersion;
      jre_headless = pkgs.openjdk21_headless;
    };

    openFirewall = true;
    jvmOpts = "-Xms2G -Xmx4G";

    symlinks = { "mods" = "${modpack}/mods"; };
    files = { "config" = "${modpack}/config"; };

    serverProperties = {
      server-port = 25565;
      motd = "Cobbleverse 1.7.42";
      max-players = 8;

      gamemode = "survival";
      difficulty = "hard";

      white-list = false;
      enforce-whitelist = false;

      online-mode = true;

      view-distance = 10;
      simulation-distance = 8;

      spawn-protection = 0;
    };
  };
}