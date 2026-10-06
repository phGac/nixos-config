{ pkgs, lib, ... }:
let 
  modpack = pkgs.fetchModrinthModpack {
    url = "https://cdn.modrinth.com/data/amLwuQbz/versions/y6jEJ1CU/modpack.mrpack";
    packHash = "sha256-c13kKdya16uJ9XOfCpBlvwPcCNwOUK9J6iVAxz1TsMI=";
    side = "server";
  };
  mcVersion = modpack.manifest.dependencies.minecraft;
  fabricVersion = modpack.manifest.dependencies.fabric-loader;
  # serverVersion = lib.replaceStrings [ "." ] [ "_" ] "fabric-${mcVersion}";
  serverVersion = "fabric-${lib.replaceStrings [ "." ] [ "_" ] mcVersion}";
in
{
  services.minecraft-servers.servers.ziptastic-26_3 = {
    enable = true;
    autoStart = false;

    package = pkgs.fabricServers.${serverVersion}.override { 
      loaderVersion = fabricVersion;
      jre_headless = pkgs.openjdk25_headless;
    };

    openFirewall = true;
    jvmOpts = "-Xms2G -Xmx2G";

    symlinks = { "mods" = "${modpack}/mods"; };
    files = { "config" = "${modpack}/config"; };

    serverProperties = {
      server-port = 25566;
      motd = "Ziptastic";
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