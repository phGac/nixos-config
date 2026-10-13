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
    url = "https://cdn.modrinth.com/data/DrmjSylV/versions/pk2aSuL3/vco%202026.mrpack";
    archiveHash = "sha256-p96IHo3lwC+px7Qg5+1x7hr8uTWaw4HFm8uPr7v6Irs=";
    packHash = "sha256-AwDLh674+XtnFQg84vgUX6VgUlxsT1g56R8NSqDxXhk=";
    side = "server";
  };
  mcVersion = modpack.manifest.dependencies.minecraft;
  # neoforgeVersion = modpack.manifest.dependencies.neoforge;
  neoforgeVersion = "21.1.233"; # Required by Fast Noise mod.
  serverVersion = lib.replaceStrings [ "." ] [ "_" ] "neoforge-${mcVersion}-${neoforgeVersion}";

  mods = filterMods [
    "entity_texture_features"
    "entity_model_features"
    "wakes-1.21.1"
    "e4mc-"
    "Controlling-"
    "skinlayers3d"
  ] (collectFilesAt modpack "mods");

  configDir = "/var/lib/minecraft-config/vampirism_co/config";
in
{
  systemd.services.minecraft-server-vampirism_co.serviceConfig = {
    PrivateDevices = lib.mkForce false;
    DevicePolicy = lib.mkForce "auto";
    DeviceAllow = lib.mkForce [];
  };

  services.minecraft-servers.servers.vampirism_co = {
    enable = true;
    autoStart = false;

    package = pkgs.neoforgeServers.${serverVersion}.override {
      jre_headless = pkgs.openjdk25_headless;
    };

    openFirewall = true;
    jvmOpts = "-Xms10G -Xmx10G -XX:+UseCompactObjectHeaders -Dchunky.maxWorkingCount=768 -XX:+UseG1GC -XX:G1HeapRegionSize=16M";

    symlinks = mods // {
      "mods/ScalableLux-0.1.0.1+neoforge.1cb1e91-all.jar" = pkgs.fetchurl {
        # A Fabric mod based on Starlight that improves the performance of light updates in Minecraft.
        url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/j10HNoNf/ScalableLux-0.1.0.1%2Bneoforge.1cb1e91-all.jar";
        hash = "sha256-dDQKN6+FgBTs9mBoBUvtOrd4si0klW00ii7CvDxYXLU=";
      };
      "mods/c2me-neoforge-mc1.21.1-0.4.0-alpha.0.122.jar" = pkgs.fetchurl {
        # A mod designed to improve the chunk performance of Minecraft.
        url = "https://cdn.modrinth.com/data/COlSi5iR/versions/yxOYFgnK/c2me-neoforge-mc1.21.1-0.4.0-alpha.0.122.jar";
        hash = "sha256-ZyvZp9w/riCBfzVj4UDYK+kIRe9Qzib1dpgILUspGMA=";
      };
      #"mods/zfastnoise-1.0.13+1.21.1+neoforge.jar" = pkgs.fetchurl {
        # Vanilla Worldgen optimization mod
      #  url = "https://cdn.modrinth.com/data/OnlVIpq5/versions/9vSFkDAr/zfastnoise-1.0.13%2B1.21.1%2Bneoforge.jar?mr_download_reason=standalone&mr_game_version=1.21.1&mr_loader=neoforge";
      #  hash = "sha256-Nu5YR1xGxW52wZnuvkjclarKoRM1EmF9zEYFMznC+10=";
      #};
      "mods/curios-neoforge-9.5.1+1.21.1.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/vvuO3ImH/versions/yohfFbgD/curios-neoforge-9.5.1%2B1.21.1.jar";
	hash = "sha256-pF3yElwmIZl0q6dQf/ya/nuDrMlBo4avP6rLHMAFb94=";
      };
      "mods/toms_storage-1.21-2.4.2.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/XZNI4Cpy/versions/WQAMoIMC/toms_storage-1.21-2.4.2.jar";
	hash = "sha256-pwPig5G5FCmCI6UVI4yHKQB2BvL5Z6g7ZbjVyzngeJ0=";
      };
      "mods/travelersbackpack-neoforge-1.21.1-10.1.39.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/rlloIFEV/versions/LcOq0PxG/travelersbackpack-neoforge-1.21.1-10.1.39.jar";
	hash = "sha256-O+rnSMTleIojU6sUrekv9ooJf8REvJW+r1JhI6WwU2s=";
      };
      "mods/TreeChop-1.21.1-neoforge-0.19.3.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/gHoB7SHO/versions/iLXWmfax/TreeChop-1.21.1-neoforge-0.19.3.jar";
	hash = "sha256-Kl7JzKGHtKAx6d1+XuyNCHL30rw1XYi9pjMCH6frcbA=";
      };
      "mods/BuildingWands-neoforge-MC1.21-2.14.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/XkisZUfp/versions/Imevjyz0/BuildingWands-neoforge-MC1.21-2.14.jar";
        hash = "sha256-efqGPrsIIvKjSCwP38mLwwl1wtlQn3rg9jKij48CSeg=";
      };
      "mods/server_waypoint-3.0.4-neoforge-mc1.21-1.21.1.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/UyBaYBa7/versions/60yrrjGa/server_waypoint-3.0.4-neoforge-mc1.21-1.21.1.jar";
        hash = "sha256-eDLshtNyldRlW75oO2x/yNjjk+yWtY0VoPB8e3E6RcA=";
      };
      "mods/structure_layout_optimizer-neoforge-1.0.12.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/ayPU0OHc/versions/eTz03Gfd/structure_layout_optimizer-neoforge-1.0.12.jar";
        hash = "sha256-746ynFxPERx0pJ03mEPkwvUdEbKMgRakm+E2Nsg/Q4U=";
      };
      "mods/servercore-neoforge-1.5.19+1.21.1.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/4WWQxlQP/versions/6N9hXiRa/servercore-neoforge-1.5.19%2B1.21.1.jar";
        hash = "sha256-pXBqoLs6R8XxratEMGaFc2aI7ANBT2C+tPy+BbmfWoI=";
      };
      "mods/resourcefulconfig-neoforge-1.21-3.0.11.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/M1953qlQ/versions/lSbyRD6v/resourcefulconfig-neoforge-1.21-3.0.11.jar";
        hash = "sha256-JbTzUC0lxTUASs1KlCAnL/8B0vHi3zUiOf7JP9qwBdQ=";
      };
      "mods/packetfixer-3.3.1-1.20.5-1.21.X-merged.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/c7m1mi73/versions/2C41Q8WX/packetfixer-3.3.1-1.20.5-1.21.X-merged.jar";
        hash = "sha256-KXmoo/ROXV30+fYxXRjCIPPev3NruKLCdArN+xO9gg8=";
      };
      "mods/Chunky-NeoForge-1.4.23.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/fALzjamp/versions/LuFhm4eU/Chunky-NeoForge-1.4.23.jar";
        hash = "sha256-1y8jXPH1byw3T1LAC92lA0UksoFCMFqEz8Ejo/kq0nQ=";
      };
      "mods/c2me-neoforge-opts-accel-opencl-mc1.21.1-0.4.0-alpha.0.122.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/qtPMklut/versions/shL6D1IO/c2me-neoforge-opts-accel-opencl-mc1.21.1-0.4.0-alpha.0.122.jar";
        hash = "sha256-6YlB4Kuot/J1/8UioVMyu7Ch22nSvB2/Wu+yYG1Hvdw=";
      };
      
      "config/c2me.toml" = "${configDir}/c2me.toml";
    };

    files =
      lib.filterAttrs
        (name: _: name != "config/c2me.toml")
        (collectFilesAt modpack "config");

    serverProperties = {
      server-port = 25565;
      motd = "Vampirism Co 2026";
      max-players = 8;
  
      gamemode = "survival";
      difficulty = "hard";

      white-list = false;
      enforce-whitelist = false;

      online-mode = true;

      view-distance = 10;
      simulation-distance = 8;

      spawn-protection = 0;
      allow-flight = true;
    };
  };
}
