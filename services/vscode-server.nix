{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.services.vscode-server;
in
{
  options.services.vscode-server = {
    enable = mkEnableOption "vscode-server daemon service";
  };

  config = mkIf cfg.enable {
    systemd.services.vscode-server = {
      unitConfig = {
        Type = "simple";
      };
      serviceConfig = {
        User = "trdthg";
        ExecStart = "${pkgs.code-server}/bin/code-server --config /home/trdthg/nixos-config/config/private/code-server.yaml --user-data-dir /home/trdthg/.vscode --bind-addr localhost:50002";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
