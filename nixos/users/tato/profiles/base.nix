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
      _mc-cmd() {
        local -a servers
        servers=(/var/lib/minecraft-servers/*(/N:t))
        compadd -- $servers
      }

      mc-log() {
        tail -F "/var/lib/minecraft-servers/$1/logs/latest.log"
      }

      mc-console() {
        sudo -u minecraft tmux \
            -S "/run/minecraft/$1.sock" \
            attach
      }

      mc-start() {
        sudo systemctl start "minecraft-server-$1"
      }

      mc-stop() {
        sudo systemctl stop "minecraft-server-$1"
      }

      mc-restart() {
        sudo systemctl restart "minecraft-server-$1"
      }

      mc-status() {
        sudo systemctl status "minecraft-server-$1"
      }

      compdef _mc-cmd mc-console
      compdef _mc-cmd mc-log
      compdef _mc-cmd mc-start
      compdef _mc-cmd mc-stop
      compdef _mc-cmd mc-restart
      compdef _mc-cmd mc-status
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