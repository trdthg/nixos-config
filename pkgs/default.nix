{ config, pkgs, ... }:
{
  imports = [
    ./python.nix
    ./java.nix
    ./docker.nix
    ./sway.nix
    ./tmp.nix
  ];

  environment.systemPackages = with pkgs; [
    texlive.combined.scheme-full

    bottom
  ];
}
