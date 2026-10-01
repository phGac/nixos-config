{
  ...
}:
{
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  networking.hosts = {
    "127.0.0.1" = [ "iny-tests.one" ];
  };

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
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

}