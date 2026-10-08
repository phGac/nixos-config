{ lib, ... }:

{
  imports =
    [
      ../../modules/common/nix.nix
      ../../modules/common/packages.nix
      ../../modules/common/locale.nix

      ../../modules/minecraft/vampirism_co.nix
    ];
}