{
  config,
  pkgs,
  ...
}: {
  # Ventoy is a tool to create bootable USB drives. It is not available in nixpkgs, so we need to add it as an insecure package.

  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.12"
    "ventoy-full"
  ];

  # command to install ventoy: nix-env -iA nixpkgs.ventoy-1.1.12
  # NIXPKGS_ALLOW_INSECURE=1 nix-shell -p ventoy

}