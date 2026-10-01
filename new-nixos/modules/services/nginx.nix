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

          # Crucial: Fixes the "upstream sent too big header" error when using Google OAuth with large cookies.
          # &
          # proxy_intercept_errors off; => Force NGINX to pass all backend status codes directly to the client
          extraConfig = ''
            proxy_buffer_size 128k;
            proxy_buffers 4 256k;
            proxy_busy_buffers_size 256k;

            proxy_intercept_errors off; 
          '';
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