{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    nodejs_22
    yarn
  ];

  home.sessionVariables = {
    NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.npm-global";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.npm-global/bin"
  ];
}