{ config, pkgs, ... }:

{
  imports =
    [
      ./profiles/base.nix
      ./profiles/dev.nix
      ./profiles/gaming.nix
      ./profiles/internet.nix
    ];
}