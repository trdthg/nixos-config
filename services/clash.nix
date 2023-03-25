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
        ExecStart = "${pkgs.clash}/bin/clash -f /home/trdthg/.config/clash/profiles/1679711267419.yml";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
