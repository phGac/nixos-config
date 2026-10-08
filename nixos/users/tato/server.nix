{ pkgs, ... }:

{
  home.username = "tato";
  home.homeDirectory = "/home/tato";
  home.stateVersion = "26.05";

  programs.zsh = {
    enable = true;
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

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "sorin";
    };
  };
}