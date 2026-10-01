{
  config,
  pkgs,
  ...
}: {
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

  home.packages = with pkgs; [
    pkgs.jetbrains.webstorm

    # postman alternative
    bruno
  ];
}
