{ config, pkgs, ... }: 

let 
  vars = import ./../../../__env.nix;
in
{
  # ###############################################################################################
  # Editors
  # ###############################################################################################

  programs.vscode = {
    enable = true;
    profiles = {
      default = {
        extensions = with pkgs.vscode-extensions; [
          #
        ];
      };
    };
  };

  # ###############################################################################################
  # Git
  # ###############################################################################################


  programs.git = {
    enable = true;
    settings = {
      user = {
        name = vars.gitUser;
        email = vars.gitEmail;
      };
      init.defaultBranch = "main";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

  # ###############################################################################################
  # Packages
  # ###############################################################################################

  home.packages = with pkgs; [
    nodejs_22
    yarn

    jetbrains.webstorm
    bruno # postman alternative
    git-filter-repo # allows to filter git history, e.g. to remove large files
  ];

  home.sessionVariables = {
    NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.npm-global";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.npm-global/bin"
  ];
}
