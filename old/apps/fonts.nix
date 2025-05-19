# Here I´m installing and configuring fonts
{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    fira-code-nerdfont
  ];
  fonts.fontconfig = {
    enable = true;
  };
}
