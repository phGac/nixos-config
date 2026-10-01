{ config, pkgs, ... }:

{
  # ###############################################################################################
  # Terminal
  # ###############################################################################################

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    
    settings = {
      shell = "${pkgs.zsh}/bin/zsh";
    };
  };

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ "kitty.desktop" ];
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    history.size = 10000;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "sorin";
    };
  };

  home.sessionVariables.TERMINAL = "kitty";

  home.packages = with pkgs; [
    kitty
    zsh
  ];
}