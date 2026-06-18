{
  config,
  pkgs,
  ...
}:{
  imports =
    [
      ./common.nix
      ./zsh.nix
      ./terminals.nix
    ];
}
