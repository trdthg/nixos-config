{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    rustup
    nodejs-16_x
  ];

  imports = [
    ./git.nix
    ./zsh.nix
    ./vscode.nix
    # ./sway.nix
  ];
}
