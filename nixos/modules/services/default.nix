{ config, pkgs, ... }:

{
  imports =
    [
      ./avahi.nix
      ./nginx.nix
      ./zerotier.nix
    ];
}