{ config, pkgs, ... }:
{
  imports = [
    ./python.nix
    ./sway.nix
  ];
}
