{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    # pkg-config
    # ninja
    # meson
    # cmake
    # wayland
    # wayland-utils
    # wayland-scanner
    # wayland-protocols
    # librime
    # libxkbcommon
    pkgs.trdthgNur.wlpinyin
  ];
}
