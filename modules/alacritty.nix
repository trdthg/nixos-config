{ config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 10;
    };
  };
}
