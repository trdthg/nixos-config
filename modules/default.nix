{ config, pkgs, ... }: {

  home.packages = with pkgs;
    [

    ];

  imports = [
    ./git.nix
    ./java.nix
    ./zsh.nix
    ./sway.nix
    ./waybar.nix
    ./nvim.nix
    ./alacritty.nix
    ./vscode.nix
  ];
}
