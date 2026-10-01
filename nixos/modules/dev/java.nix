{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    javaPackages.compiler.temurin-bin.jdk-21
  ];
}