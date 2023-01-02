{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    pkgs.htop

    go

    rustup
    # some rust openssl need
    pkg-config
    openssl
    expat
    fontconfig

    nodejs-16_x
    yarn
    nodePackages.pnpm
    deno

  ];

  imports = [
    ./git.nix
    ./zsh.nix
    ./vscode.nix
    ./sway.nix
    ./waybar.nix
  ];
}
