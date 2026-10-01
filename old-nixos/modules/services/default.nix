{
  config,
  pkgs,
  ...
}: {
  imports =
    [
      ./nginx.nix
      ./docker.nix
      ./zerotier.nix
      ./avahi.nix
    ];

}