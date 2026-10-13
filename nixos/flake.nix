{
  description = "Personal NixOS configuration";

  # Optional step. Binary cache to improve the build time
  nixConfig = {
    extra-substituters = [ "https://playit-nixos-module.cachix.org" ];
    extra-trusted-public-keys = [ "playit-nixos-module.cachix.org-1:22hBXWXBbd/7o1cOnh+p0hpFUVk9lPdRLX3p5YSfRz4=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nix-minecraft, playit-nixos-module, home-manager, ... }: 
  {
    nixosConfigurations = {
      "tato-desktop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          pkgs-unstable = import inputs.nixpkgs-unstable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };

        modules = [
          ./hosts/tato-desktop/configuration.nix
          home-manager.nixosModules.home-manager

          nix-minecraft.nixosModules.minecraft-servers
          {
            nixpkgs.overlays = [ nix-minecraft.overlay ];
          }
        ];
      };

      "home-server" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          pkgs-unstable = import inputs.nixpkgs-unstable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };

        modules = [
          ./hosts/home-server
          home-manager.nixosModules.home-manager

	  playit-nixos-module.nixosModules.default
          nix-minecraft.nixosModules.minecraft-servers
          {
            nixpkgs.overlays = [ nix-minecraft.overlay ];
          }
        ];
      };
    };
  };
}
