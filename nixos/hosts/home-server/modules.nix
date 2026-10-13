{ lib, ... }:

{
  imports =
    [
      ../../modules/common/nix.nix
      ../../modules/common/packages.nix
      ../../modules/common/network.nix
      ../../modules/desktop/graphics-intel-legacy.nix

      ../../modules/minecraft/common.nix
      ../../modules/minecraft/vampirism_co.nix
    ];
}
