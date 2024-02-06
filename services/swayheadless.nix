{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.services.swayheadless;
in
{
  options.services.swayheadless = {
    enable = mkEnableOption "swayheadless daemon service";
  };

  config = mkIf cfg.enable {
    systemd.services.swayheadless = {
      unitConfig = {
        Type = "simple";
      };
      serviceConfig = {
        PermissionsStartOnly = "True";
        RuntimeDirectory = "swayheadless";
        RuntimeDirectoryMode = "0775";
        User = "trdthg";
        Environment = [
          "WLR_BACKENDS=headless"
          "WLR_LIBINPUT_NO_DEVICES=1"
          "XDG_RUNTIME_DIR=/run/swayheadless"
          "PATH=$PATH:${pkgs.dbus}/bin:${pkgs.waybar}/bin:${pkgs.kitty}/bin:${pkgs.firefox}/bin:${pkgs.wofi}/bin"
        ];
        ExecStart = ''${pkgs.sway}/bin/sway'';
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
