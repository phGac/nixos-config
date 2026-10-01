{ config, pkgs, ... }:

{
  services.logiops.enable = true; # controlador de código abierto en espacio de usuario para dispositivos Logitech.

  environment.sessionVariables = {
    # Evita que se eliminen los archivos de caché de shaders de OpenGL al cerrar Steam, lo que puede mejorar el rendimiento en algunos juegos.
    __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
  };

  home.packages = with pkgs; [
    protonup-qt
    heroic # launcher que permite jugar títulos de Epic Games Store, GOG y Amazon Prime Games

    # mouse configuration tool
    solaar
    # Logitech devices configuration tool (mouse buttons)
    logiops
  ];
}