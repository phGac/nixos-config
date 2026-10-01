{ home-manager, ... }:

{ username
, homeDirectory
, extraModules ? [ ]
, extraSpecialArgs ? { }
}:

home-manager.lib.homeManagerConfiguration {
  inherit username homeDirectory;

  extraSpecialArgs = extraSpecialArgs;

  modules = [
    {
      home.username = username;
      home.homeDirectory = homeDirectory;
      home.stateVersion = "26.05";
      programs.home-manager.enable = true;
    }
    ./users/${username}/profiles/base.nix
  ] ++ extraModules;
}