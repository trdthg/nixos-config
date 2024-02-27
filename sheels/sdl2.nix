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
  nativeBuildInputs = with pkgs; [
    pkgconfig
    # clang
    # lld # To use lld linker
  ];
  buildInputs = with pkgs;[
    # cargo
    # rustc
    # rustfmt
    # pre-commit
    # rustPackages.clippy
    # alsa-lib
    udev
    #NOTE Add more deps
    # vulkan-loader
    xorg.libX11
    # x11
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXi
  ];
  shellHook = ''
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${
      pkgs.lib.makeLibraryPath  [
        pkgs.udev
        # pkgs.alsaLib
        # pkgs.vulkan-loader
      ]
    }"'';
  # RUST_SRC_PATH = rustPlatform.rustLibSrc;

}
