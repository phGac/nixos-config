{ pkgs, lib, ... }:
let 
  modpack = pkgs.fetchModrinthModpack {
    url = "https://cdn.modrinth.com/data/oePruTVg/versions/1JMKPvtY/keo%20optimized%2026.2.mrpack";
    packHash = "";
    side = "server";
  };
  mcVersion = modpack.manifest.dependencies.minecraft;
  fabricVersion = modpack.manifest.dependencies.fabric-loader;
  # serverVersion = lib.replaceStrings [ "." ] [ "_" ] "fabric-${mcVersion}";
  serverVersion = "fabric-${lib.replaceStrings [ "." ] [ "_" ] mcVersion}";
in
{
  services.minecraft-servers.servers.keooptimized-26_2 = {
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
      motd = "Keo Optimized";
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