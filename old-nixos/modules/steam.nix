{
  config,
  pkgs,
  ...
}: {

  nixpkgs.overlays = [
    # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # Temporarily disabled due to issues with steam. (https://discourse.nixos.org/t/openblas-i686-linux-hangs-in-checkphase-on-zblat3/78487/5)
    # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    (final: prev: {
      openblas =
        if prev.stdenv.hostPlatform.system == "i686-linux"
        then prev.openblas.overrideAttrs (_: {doCheck = false;})
        else prev.openblas;
    })
  ];

  environment.systemPackages = with pkgs; [
    protonup-qt

    # mouse configuration tool
    solaar
    # Logitech devices configuration tool (mouse buttons)
    logiops
  ];

  services.logiops.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.gamemode.enable = true;

  # Enable controller support for Steam games.
  hardware.steam-hardware.enable = true;

  environment.sessionVariables = {
    # Evita que se eliminen los archivos de caché de shaders de OpenGL al cerrar Steam, lo que puede mejorar el rendimiento en algunos juegos.
    __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
  };

}