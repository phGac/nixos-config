{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    unzip
    javaPackages.compiler.temurin-bin.jdk-21
    zed-editor
  ];
}
