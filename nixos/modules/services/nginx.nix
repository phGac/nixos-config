{
  config,
  pkgs,
  ...
}: 

let 
  vars = import ./../../__env.nix;
in
{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "iny-tests.one" = {
        forceSSL = true;
        enableACME = true;

        locations."/" = {
          proxyPass = "http://localhost:8080";
          proxyWebsockets = true;
        };
      };
    };
  };

  # Self-signed certificates settings.
  security.acme = {
    acceptTerms = true;
    defaults.email = vars.acmeEmail;
  };

  # Open ports in the firewall. 
  # File:
  # .../hosts/.../network.nix

  #networking.firewall.allowedTCPPorts = [ 80 443 ];

}