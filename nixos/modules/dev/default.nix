{ config, pkgs, ... }:

{
  imports =
    [
      ./docker.nix
      ./editor.nix
      ./java.nix
      ./node.nix
    ];
}