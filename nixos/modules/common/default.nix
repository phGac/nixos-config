{ config, pkgs, ... }:

{
  imports =
    [
      ./nix.nix
      ./audio.nix
      ./bluetooth.nix
      ./locale.nix
      ./network.nix
      ./packages.nix
      ./security.nix
    ];
}