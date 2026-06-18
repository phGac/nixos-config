{
  config,
  pkgs,
  ...
}: {
  # Bootloader.
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;
  #boot.loader.grub.efiSupport = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.supportedFilesystems = [ "ntfs" ];

}