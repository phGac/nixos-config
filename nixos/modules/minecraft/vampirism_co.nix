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
  ] (collectFilesAt modpack "mods");
in
{
  services.minecraft-servers.servers.vampirism_co = {
    enable = true;
    autoStart = false;

    package = pkgs.neoforgeServers.${serverVersion}.override {
      jre_headless = pkgs.openjdk21_headless;
    };

    openFirewall = true;
    jvmOpts = "-Xms2G -Xmx4G";

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
      "mods/zfastnoise-1.0.13+1.21.1+neoforge.jar" = pkgs.fetchurl {
        # Vanilla Worldgen optimization mod
        url = "https://cdn.modrinth.com/data/OnlVIpq5/versions/9vSFkDAr/zfastnoise-1.0.13%2B1.21.1%2Bneoforge.jar?mr_download_reason=standalone&mr_game_version=1.21.1&mr_loader=neoforge";
        hash = "sha256-Nu5YR1xGxW52wZnuvkjclarKoRM1EmF9zEYFMznC+10=";
      };
    };
    files = { "config" = "${modpack}/config"; };

    serverProperties = {
      server-port = 50500;
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