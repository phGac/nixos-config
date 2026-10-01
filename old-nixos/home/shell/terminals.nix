{
  config,
  pkgs,
  ...
}:{
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

  home.sessionVariables.TERMINAL = "kitty";
}
