{ config, pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    protonup-qt
    heroic # launcher que permite jugar títulos de Epic Games Store, GOG y Amazon Prime Games

    # mouse configuration tool
    solaar
    # Logitech devices configuration tool (mouse buttons)
    logiops

    # Minecraft
    pkgs-unstable.prismlauncher
    mangohud

    # Minecraft modpack management tools
    packwiz
    tmux
  ];
}