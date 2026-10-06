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

    initContent = ''
      mc-log() {
        tail -F "/var/lib/minecraft-servers/$1/logs/latest.log"
      }

      _mc-log() {
        local -a servers
        servers=(/var/lib/minecraft-servers/*(/N:t))
        compadd -- $servers
      }

      mc-console() {
        sudo -u minecraft tmux \
            -S "/run/minecraft/$1.sock" \
            attach
      }

      compdef _mc-log mc-log
      compdef _mc-log mc-console
    '';

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