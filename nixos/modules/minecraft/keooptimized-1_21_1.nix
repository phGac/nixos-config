{ pkgs, lib, inputs, ... }:
let
  inherit (inputs.nix-minecraft.lib) collectFilesAt;
   
  fetchModrinthModpackFixed = import ../../lib/fetchModrinthModpack.nix {
    inherit pkgs lib;
  };

  filterMods = 
    import ../../lib/filterMods.nix {
      inherit lib;
    }; 

  modpack = fetchModrinthModpackFixed {
    url = "https://cdn.modrinth.com/data/oePruTVg/versions/2nv2hItC/Keo%20optimized%201.21.1%20neoforge.mrpack";
    archiveHash = "sha256-kNzwiXpMsK4e57qSVxuBFaZEW4ga5ApFiw7eI2MhuSM=";
    packHash = "sha256-Mn1b04EClwcm3tx9if4XxSGfiOYjPGkBk/Rd5OZlSiM=";
    side = "server";
  };
  mcVersion = modpack.manifest.dependencies.minecraft;
  neoforgeVersion = modpack.manifest.dependencies.neoforge;
  serverVersion = lib.replaceStrings [ "." ] [ "_" ] "neoforge-${mcVersion}-${neoforgeVersion}";
  # serverVersion = "neoforge-${lib.replaceStrings [ "." ] [ "_" ] mcVersion}";

  mods = filterMods [
    "c2me"
    "noisium"
  ] (collectFilesAt modpack "mods");
in
{

  systemd.services.minecraft-server-keooptimized-1_21_1.serviceConfig = {
    PrivateDevices = lib.mkForce false;
    DevicePolicy = lib.mkForce "auto";
    DeviceAllow = lib.mkForce [];
  };

  services.minecraft-servers.servers.keooptimized-1_21_1 = {
    enable = true;
    autoStart = false;

    package = pkgs.neoforgeServers.${serverVersion}.override { 
      jre_headless = pkgs.openjdk25_headless;
    };

    openFirewall = true;
    jvmOpts = "-Xms6G -Xmx6G";

    symlinks = mods // {
      "mods/c2me-neoforge-mc1.21.1-0.4.0-alpha.0.122.jar" = pkgs.fetchurl {
        # A mod designed to improve the chunk performance of Minecraft.
        url = "https://cdn.modrinth.com/data/COlSi5iR/versions/yxOYFgnK/c2me-neoforge-mc1.21.1-0.4.0-alpha.0.122.jar";
        hash = "sha256-ZyvZp9w/riCBfzVj4UDYK+kIRe9Qzib1dpgILUspGMA=";
      };
      "mods/c2me-neoforge-opts-accel-opencl-mc1.21.1-0.4.0-alpha.0.122.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/qtPMklut/versions/shL6D1IO/c2me-neoforge-opts-accel-opencl-mc1.21.1-0.4.0-alpha.0.122.jar";
        hash = "sha256-6YlB4Kuot/J1/8UioVMyu7Ch22nSvB2/Wu+yYG1Hvdw=";
      };
    };
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
