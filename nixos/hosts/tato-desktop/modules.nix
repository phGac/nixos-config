{ ... }:

{
  imports = [
    ../../modules/common
    ../../modules/desktop
    ../../modules/dev
    ../../modules/services
    ../../modules/desktop/graphics-nvidia.nix

    ../../modules/minecraft/common.nix
    # ../../modules/minecraft/vanilla-26_3.nix
    # ../../modules/minecraft/ziptastic.nix
    # ../../modules/minecraft/keooptimized-26_2.nix
    ../../modules/minecraft/cobbleverse.nix
  ];
}