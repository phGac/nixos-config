{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.12"
    "ventoy-full"
  ];
}