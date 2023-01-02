{ config, pkgs, ... }:
with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    # vscode can't detect these
    # pip
    # black
    # requests
    # other python packages you want
  ];
  python-with-my-packages = python3.withPackages my-python-packages;
in
{
  environment.systemPackages = with pkgs; [
    python310
    # python310Packages.pip
    python-with-my-packages
    poetry
  ];
}
