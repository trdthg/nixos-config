{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.services.clash;
in
{
  options.services.clash = {
    enable = mkEnableOption "clash daemon service";
  };

  config = mkIf cfg.enable {
    systemd.services.clash = {
      unitConfig = {
        Type = "simple";
      };
      serviceConfig = {
        User = "trdthg";
        ExecStart = "${pkgs.clash-meta}/bin/clash-meta -f /home/trdthg/.config/clash/profiles/release.yml";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
