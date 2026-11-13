{ config, pkgs, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    loadModels = [ "nomic-embed-text:v1.5" ];
  };
}