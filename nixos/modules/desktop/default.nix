{ config, pkgs, ... }:

{
  imports =
    [
      ./gaming.nix
      ./media.nix
    ];
}