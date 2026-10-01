{ nixpkgs, home-manager, ... }:

{ hostName
, system ? "x86_64-linux"
, user
, modules ? []
, extraSpecialArgs ? { }
}:

nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit user;
  } // extraSpecialArgs;

  modules = [
    {
      networking.hostName = hostName;
      users.users."${user}" = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "docker" ];
      };
    }
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users."${user}" = import ../users/${user}/home.nix;
    }
  ] ++ modules;
}