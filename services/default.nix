{ config, pkgs, ... }:
{
  imports = [
    ./frpc.nix
    ./vscode-server.nix
    ./clash.nix
  ];
}
