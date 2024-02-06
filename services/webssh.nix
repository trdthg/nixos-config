{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.services.webssh;
in
{
  options.services.webssh = {
    enable = mkEnableOption "webssh daemon service";
  };

  config = mkIf cfg.enable {
    systemd.services.webssh = {
      unitConfig = {
        Type = "simple";
      };
      serviceConfig = {
        User = "trdthg";
        ExecStart = "${pkgs.webssh}/bin/wssh --port=8888";
        Restart = "always";
        StartLimitIntervalSec = 5;
        StartLimitBurst = 10000;
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
