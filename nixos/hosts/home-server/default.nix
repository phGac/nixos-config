{ config, pkgs, ... }:

{
  imports = 
    [
      ./hardware-configuration.nix
      ./boot.nix
      ./network.nix
      ./locale.nix
      ./zsh.nix
      ./users.nix
      ./modules.nix
      ./playit.nix
    ];

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    tmux
  ];

  networking.hostName = "home-server";
  system.stateVersion = "26.05";
}
