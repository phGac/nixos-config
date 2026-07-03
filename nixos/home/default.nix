{
  pkgs,
  ... 
}:
{
  imports =
    [
      ./programs/default.nix
      ./shell/default.nix
      ./dev/default.nix
      ./tools/default.nix
    ];

  programs.home-manager.enable = true;

  home.username = "tato";
  home.homeDirectory = "/home/tato";
  home.stateVersion = "26.05";
}
