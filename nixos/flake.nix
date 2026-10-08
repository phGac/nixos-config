{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nix-minecraft, home-manager, ... }: 
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
          ./hosts/tato-desktop
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

          nix-minecraft.nixosModules.minecraft-servers
          {
            nixpkgs.overlays = [ nix-minecraft.overlay ];
          }
        ];
      };
    };
  };
}
