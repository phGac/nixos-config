{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sqlite
    sqlite-interactive
  ];
}