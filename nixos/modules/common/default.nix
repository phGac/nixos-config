{ config, pkgs, ... }:

{
  imports =
    [
      ./nix.nix
      ./audio.nix
      ./bluetooth.nix
      ./locale.nix
      ./networking.nix
      ./packages.nix
      ./security.nix
    ];
}