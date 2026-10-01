{ config, pkgs, ... }:

{
  programs.gamemode.enable = true;
  hardware.steam-hardware.enable = true; # Enable controller support for Steam games.

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}