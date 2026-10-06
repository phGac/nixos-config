{ ... }:

{
  services.minecraft-servers = {
    enable = true;
    eula = true;
    dataDir = "/var/lib/minecraft-servers";
  };
}