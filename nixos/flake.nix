{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    #flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, home-manager, ... }: 
    let
      lib = import ./lib { 
        inherit inputs;
        inherit (nixpkgs) lib;
      };
    in {
      nixosConfigurations = {
        "tato-desktop" = lib.mkSystem {
          hostname = "tato-desktop";
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
