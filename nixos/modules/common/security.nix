{ config, pkgs, ... }:

{
  security = {
    # efine si los usuarios pertenecientes al grupo administrativo wheel deben introducir su contraseña personal al ejecutar comandos como superusuario (root) usando sudo
    sudo.wheelNeedsPassword = true;
    # (RealtimeKit) es un servicio del sistema que otorga prioridad de procesamiento en tiempo real a los procesos de usuario que lo solicitan de forma segura
    rtkit.enable = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  networking.firewall.enable = true;
}