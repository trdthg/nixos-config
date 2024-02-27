{ pkgs, unstable-pkgs, ... }:
let
  # pkgs = import <nixpkgs> { };
  # unstableTarball =
  # fetchTarball
  # https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
  # pkgs = import <nixpkgs> { };
  # unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
  # unstable = import unstableTarball { };
  # unstable = import <nixos-unstable> { };
  # unstable = import <nixos-unstable> { };
in
pkgs.mkShell {

  # build
  nativeBuildInputs = with unstable-pkgs; [
    gcc
    # libstdcxx5
    pkg-config
    ninja
    meson
    cmake
    wayland
    wayland-utils
    wayland-scanner
    wayland-protocols
    librime
    libxkbcommon
    tree
  ];
  #  ++ [ unstable.librime ];

  # runtime
  buildInputs = with pkgs;[
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
    # tree
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${
      pkgs.lib.makeLibraryPath [
        pkgs.libstdcxx5
      ]
    }"
    export PATH="$PATH:${
      pkgs.lib.makeBinPath [
        # pkgs.wayland-scanner
      ]
    }"
  '';
}
