{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "trdthg";
    userEmail = "trdthg47@gmail.com";
  };
}
