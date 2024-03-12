{ config, pkgs, ... }:
{
  imports = [
    ./frpc.nix
    # ./vscode-server.nix
    ./clash.nix
    ./swayheadless.nix
    ./wayvnc.nix
    ./webssh.nix
  ];
}
