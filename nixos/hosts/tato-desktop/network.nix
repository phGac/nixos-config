{ config, pkgs, ... }:

{
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
}