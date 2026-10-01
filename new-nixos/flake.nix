{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    #flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
    let
      mkSystem = import ./lib/mkSystem.nix { inherit nixpkgs home-manager; };
      mkHome = import ./lib/mkHome.nix { inherit home-manager; };
    in {
      nixosConfigurations = {
        desktop = mkSystem {
          hostName = "desktop";
          system = "x86_64-linux";
          user = "tato";
          modules = [
            ./hosts/desktop/default.nix
            ./modules/common
            ./modules/desktop
            ./modules/dev
            ./modules/services
          ];
        };
      };

      homeConfigurations = {
        "tato@desktop" = mkHome {
          username = "tato";
          homeDirectory = "/home/tato";
          extraModules = [
            ./users/tato/profiles/dev.nix
            ./users/tato/profiles/gaming.nix
            ./users/tato/profiles/internet.nix
          ];
        };
      }
    };
}