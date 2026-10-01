{
  config,
  pkgs,
  ...
}: {
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "743993800f6e9107" ];
  };

  environment.systemPackages = with pkgs; [
    zerotierone
  ];
}