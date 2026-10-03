{ config, pkgs, ... }:

{
  home.username = "tato";
  home.homeDirectory = "/home/tato";
  home.stateVersion = "26.05";

  imports =
    [
      ./profiles/base.nix
      ./profiles/dev.nix
      ./profiles/gaming.nix
      ./profiles/internet.nix
    ];
}