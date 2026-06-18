{
  description = "Home-Manager configuration for NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {

      modules = [
        #./configuration.nix
        ./modules/system.nix
        ./hosts/nixos/default.nix
        ./modules/steam.nix
        ./modules/services/default.nix
        
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          users.users."tato" = {
            isNormalUser = true;
            description = "tato";
            extraGroups = [ "networkmanager" "wheel" "docker" ];
          };

          home-manager.users."tato" = import ./home/default.nix;
        }
      ];
    };
  };
}
