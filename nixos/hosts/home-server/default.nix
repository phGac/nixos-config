{ config, pkgs, ... }:

{
  imports = 
    [
      ./hardware-configuration.nix
      ./network.nix
      ./zsh.nix
      ./users.nix
      ./modules.nix
    ];

  networking.hostName = "home-server";
  system.stateVersion = "26.05";
}