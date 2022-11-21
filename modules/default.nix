{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    pkgs.htop
    rustup
    nodejs-16_x
  ];

  imports = [
    ./git.nix
    ./zsh.nix
    ./vscode.nix
    ./sway.nix
  ];
}
