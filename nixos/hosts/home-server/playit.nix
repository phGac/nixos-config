{ config, ... }:

{
  services.playit = {
    enable = true;
    secretPath = "/etc/playit/secret.toml";
  };
}
