{ 
  config, 
  pkgs, 
  ... 
}:{
  imports =
    [
      ./browsers.nix
      ./common.nix
      ./git.nix
      ./editors.nix
      ./minecraft.nix
    ];
}
