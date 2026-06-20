{
  config,
  pkgs,
  ...
}:

let 
  vars = import ./../../__env.nix;
in
{
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
}
