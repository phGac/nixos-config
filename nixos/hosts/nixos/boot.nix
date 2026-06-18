{
  ...
}: 
{
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/nvme0n1";
        useOSProber = true;
        #efiSupport = true;
      };
      efi = {
        #canTouchEfiVariables = true;
        #efiSysMountPoint = "/boot/efi";
      };
    };

    supportedFilesystems = [ "ntfs" ];
  };
}