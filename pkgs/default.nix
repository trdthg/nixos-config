{ config, pkgs, ... }:
{
  imports = [
    ./python.nix
    ./docker.nix
    ./sway.nix
  ];

  environment.systemPackages = with pkgs; [
    texlive.combined.scheme-full

    bottom
  ];
}
