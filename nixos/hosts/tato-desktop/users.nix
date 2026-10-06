{ config, pkgs, pkgs-unstable, lib, ... }:

{
  users.users.tato = {
    isNormalUser = true;
    description = "Tato";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "minecraft"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit pkgs-unstable;
    };

    users.tato = {
      imports = [
        ../../users/tato/home.nix
      ];
    };
  };

  /*
  options = {
    services.minecraft-servers = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether to enable the Minecraft server.";
          };
        };
      });
      default = {};
      description = "Configuration for Minecraft servers.";
    };
  };

  config = lib.mkIf (config.services.minecraft-servers != {}) {
    systemd.services.minecraft-servers = lib.mkIf (config.services.minecraft-servers != {}) {
      description = "Minecraft Servers";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c 'for server in ${lib.concatStringsSep " " (lib.attrNames config.services.minecraft-servers)}; do echo Starting $server; done'";
      };
    };
  };
  */
}