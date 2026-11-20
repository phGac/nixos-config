{ inputs, ... }:

let
  pkgsOllama = import inputs.nixpkgs-ollama {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  services.ollama = {
    enable = true;
    package = pkgsOllama.ollama-cuda;
    loadModels = [ "nomic-embed-text:v1.5" ];
  };
}