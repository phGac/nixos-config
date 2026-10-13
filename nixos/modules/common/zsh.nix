{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    histSize = 10000;

    shellAliases = {
      ll = "ls -l";
    };
  };

  environment.shells = [ pkgs.zsh ];
}
