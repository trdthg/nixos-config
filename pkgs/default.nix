{ config, pkgs, ... }:
{
  imports = [
    ./python.nix
    ./sway.nix
  ];

  environment.systemPackages = with pkgs; [
    texlive.combined.scheme-full

    bottom
  ];
}
