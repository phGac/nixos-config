{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    curl
    unzip
    # git
    htop
    # btop # es un monitor de recursos para la terminal que muestra el uso de la CPU, la memoria, los discos, la red y los procesos en tiempo real con una interfaz gráfica moderna. Permite usar el mouse.
    # fd # comando (fd) para buscar archivos y directorios de forma rápida y sencilla
    # ripgrep # comando (rp) para buscar patrones de texto y expresiones regulares de forma recursiva en archivos
    # jq # jq es una herramienta de línea de comandos ligera y potente para procesar, filtrar, mapear y transformar datos en formato JSON de forma similar a como sed, awk o grep funcionan con texto.
  ];
}