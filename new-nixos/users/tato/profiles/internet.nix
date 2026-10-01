{ config, pkgs, ... }:

{
  programs.firefox.enable = true;

  home.packages = with pkgs; [
    easyeffects # Allows to apply effects to audio input/output, like equalizer, compressor, etc.
    (discord.override {
     withVencord = true;
    })
  ];
}