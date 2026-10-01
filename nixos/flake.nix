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

  outputs = inputs@{ nixpkgs, home-manager, ... }: 
    let
      lib = import ./lib { 
        inherit inputs;
        inherit (nixpkgs) lib;
      };
    in {
      nixosConfigurations = {
        desktop = lib.mkSystem {
          hostname = "desktop";
          system = "x86_64-linux";
          users = ["tato"];
          modules = [
            ./modules/common
            ./modules/desktop
            ./modules/dev
            ./modules/services

            ./modules/desktop/graphics-nvidia.nix
          ];
        };
      };
    };
}