{ config, pkgs, ... }:

{
  networking.hostName = "tato-desktop";
  system.stateVersion = "26.05";

  imports =
    [
      ./hardware-configuration.nix
      ./boot.nix
      ./network.nix
      ./users.nix
      ./modules.nix
    ];

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  services.xrdp = {
    enable = true;
    defaultWindowManager = "xfce4-session";
    port = 3389;
    openFirewall = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Permite usar paquetes globales de Nix en el sistema como nodejs, yarn, etc.
  programs.nix-ld.enable = true;

  # Enable zsh completion to get completion for system packages (e.g. systemd)
  environment.pathsToLink = [ "/share/zsh" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # system.stateVersion = "26.05"; # Did you read the comment?
}