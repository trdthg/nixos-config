{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.services.frpc;
in
{
  options.services.frpc = {
    enable = mkEnableOption "frpc daemon service";
    # greeter = mkOption {
    #   type = types.str;
    #   default = "world";
    # };
  };

  config = mkIf cfg.enable {
    systemd.services.frpc = {
      unitConfig = {
        Type = "simple";
        After = "NetworkManager.service";
        Requires = "NetworkManager.service";
      };
      serviceConfig = {
        User = "trdthg";
        ExecStart = "${pkgs.frp}/bin/frpc -c /home/trdthg/nixos-config/config/private/frpc.ini";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
