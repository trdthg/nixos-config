let
  # pkgs = import <nixpkgs> { };
  # unstableTarball =
  # fetchTarball
  # https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
  pkgs = import <nixpkgs> { };
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
  # unstable = import unstableTarball { };
  # unstable = import <nixos-unstable> { };
  # unstable = import <nixos-unstable> { };
in
pkgs.mkShell {

  # build
  nativeBuildInputs = with pkgs; [
    pkg-config
    ninja
    meson
    cmake
    wayland
    wayland-utils
    wayland-scanner
    wayland-protocols

    libxkbcommon
    tree
  ] ++ [ unstable.librime ];

  # runtime
  buildInputs = with pkgs;[
  ];

  # export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.xorg.libX11.dev}/lib:${pkgs.gtk3}/lib:${pkgs.pango.dev.out}/lib:${pkgs.pcre2}/lib";
  shellHook = ''
  '';
}
