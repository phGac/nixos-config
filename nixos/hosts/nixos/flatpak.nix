{
  ...
}:
{
  services.flatpak.enable = true;
  
  environment.sessionVariables = {
    XDG_DATA_DIRS = [
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
      "$HOME/.nix-profile/share"
    ];
  };

}