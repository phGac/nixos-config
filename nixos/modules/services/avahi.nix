{ config, pkgs, ... }:

{
  # 1. Instalar el paquete de Sunshine
  environment.systemPackages = [
    pkgs.sunshine
  ];

  # 2. Habilitar Avahi para que Windows detecte a NixOS en la red automáticamente
  services.avahi.enable = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;

  /*
  # 3. Abrir los puertos específicos requeridos por Sunshine/Moonlight
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 47984 47989 47990 48010 ];
    allowedUDPPortRanges = [
      { from = 47998; to = 48000; }
      { from = 8000; to = 8010; }
    ];
  };
  */

  # 4. Asegurar los permisos necesarios para la captura de pantalla por hardware (KMS)
  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+ep";
    source = "${pkgs.sunshine}/bin/sunshine";
  };
}