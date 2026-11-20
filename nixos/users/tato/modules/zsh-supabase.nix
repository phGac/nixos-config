{ pkgs, ... }:

{
  programs.zsh.initContent = builtins.readFile ./supabase.zsh;
}
