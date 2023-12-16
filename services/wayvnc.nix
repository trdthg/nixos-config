{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.services.wayvnc;
in
{
  options.services.wayvnc = {
    enable = mkEnableOption "wayvnc daemon service";
  };

  config = mkIf cfg.enable {
    systemd.services.wayvnc = {
      unitConfig = {
        Type = "simple";
        Requires = "swayheadless.service";
        After = "swayheadless.service";
      };
      serviceConfig = {
        User = "trdthg";
        Environment = [
          "WAYLAND_DISPLAY=wayland-1"
          "XDG_RUNTIME_DIR=/run/swayheadless"
        ];
        ExecStart = "${pkgs.wayvnc}/bin/wayvnc 0.0.0.0 5901";
        Restart = "always";
        StartLimitIntervalSec = 5;
        StartLimitBurst = 10;
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
