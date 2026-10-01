{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;
  boot.supportedFilesystems = [ "ntfs" ];
  # boot.loader.grub.efiSupport = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";


  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;


  networking.hosts = {
    "127.0.0.1" = [ "iny-tests.one" ];
  };

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [ 
      80 
      443 
      50500 # Minecraft server port
      3389

      # puertos requeridos por Sunshine/Moonlight
      47984 47989 47990 48010

      # puertos usados por supabase
      54323 54324 54321
    ];
    allowedUDPPorts = [
      50500 # Minecraft server port
    ];
    allowedUDPPortRanges = [
      # puertos requeridos por Sunshine/Moonlight
      { from = 47998; to = 48000; }
      # puertos requeridos por Sunshine/Moonlight
      { from = 8000; to = 8010; }
    ];
  };

  services.xrdp = {
    enable = true;
    defaultWindowManager = "xfce4-session";
    port = 3389;
    openFirewall = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Permite usar el comando supabase (npm)
  programs.nix-ld.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # system.stateVersion = "26.05"; # Did you read the comment?
}