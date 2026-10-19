{ pkgs, lib, inputs, ... }:
let
  inherit (inputs.nix-minecraft.lib) collectFilesAt;
   
  fetchCurseforgeModpack = import ../../lib/fetchCurseforgeModpack.nix {
    inherit pkgs lib;
  };

  filterMods = 
    import ../../lib/filterMods.nix {
      inherit lib;
    }; 

  modpack = fetchCurseforgeModpack {
    lockFile = ../../packs/keo-optimized.json;
    pname = "keo-optimized";
    version = "1_21_1-curseforge";
  };
  mcVersion = modpack.manifest.minecraft.version;
  neoforgeVersion = lib.replaceStrings [ "neoforge-" ] [ "" ] (builtins.head modpack.manifest.minecraft.modLoaders).id;
  serverVersion = lib.replaceStrings [ "." ] [ "_" ] "neoforge-${mcVersion}-${neoforgeVersion}";

  # mods = filterMods [
  #   "c2me"
  #   "noisium"
  # ] (collectFilesAt modpack "mods");
in
{

  systemd.services.minecraft-server-keooptimized-1_21_1-curseforge.serviceConfig = {
    PrivateDevices = lib.mkForce false;
    DevicePolicy = lib.mkForce "auto";
    DeviceAllow = lib.mkForce [];
  };

  services.minecraft-servers.servers.keooptimized-1_21_1-curseforge = {
    enable = true;
    autoStart = false;

    package = pkgs.neoforgeServers.${serverVersion}.override { 
      jre_headless = pkgs.openjdk25_headless;
    };

    openFirewall = true;
    jvmOpts = "-Xms6G -Xmx6G";

    # symlinks = mods;
    #  // {
    #   "mods/c2me-neoforge-mc1.21.1-0.4.0-alpha.0.122.jar" = pkgs.fetchurl {
    #     # A mod designed to improve the chunk performance of Minecraft.
    #     url = "https://cdn.modrinth.com/data/COlSi5iR/versions/yxOYFgnK/c2me-neoforge-mc1.21.1-0.4.0-alpha.0.122.jar";
    #     hash = "sha256-ZyvZp9w/riCBfzVj4UDYK+kIRe9Qzib1dpgILUspGMA=";
    #   };
    #   "mods/c2me-neoforge-opts-accel-opencl-mc1.21.1-0.4.0-alpha.0.122.jar" = pkgs.fetchurl {
    #     url = "https://cdn.modrinth.com/data/qtPMklut/versions/shL6D1IO/c2me-neoforge-opts-accel-opencl-mc1.21.1-0.4.0-alpha.0.122.jar";
    #     hash = "sha256-6YlB4Kuot/J1/8UioVMyu7Ch22nSvB2/Wu+yYG1Hvdw=";
    #   };
    # };
    symlinks = { "mods" = "${modpack}/mods"; };
    files = { "config" = "${modpack}/config"; };

    serverProperties = {
      server-port = 25566;
      motd = "Keo Optimized - CurseForge";
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
