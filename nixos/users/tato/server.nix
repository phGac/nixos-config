{ pkgs, ... }:

{
  home.username = "tato";
  home.homeDirectory = "/home/tato";
  home.stateVersion = "26.05";

  imports = [
    ./modules/zsh-mc.nix
  ];

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "sorin";
    };
  };
}
