{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      experimental = true;
      default-address-pool = [
        {
          base = "192.168.100.0/16";
          size = 24;
        }
      ];
    };
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}