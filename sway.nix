{ config, pkgs, lib, ... }:

{

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      vscode
      alacritty
      wofi
      bemenu
      grim
      gnome3.adwaita-icon-theme
      waybar
      swaylock
      swayidle
      mako
    ];
    extraSessionCommands = ''
      export GTK_IM_MODULE=fcitx5
      export XMODIFIERS=@im=fcitx5
      export QT_IM_MODULE=fcitx5

      # export GDK_SCALE=2
      # export GDK_DPI_SCALE=0.5

      fcitx5

      export MOZ_ENABLE_WAYLAND=1
    '';
  };
}
