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
        ExecStart = "${pkgs.openvscode-server}/bin/openvscode-server --connection-token-file /home/trdthg/nixos-config/config/private/openvscode-server.token  --host 0.0.0.0 --port 50002";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
