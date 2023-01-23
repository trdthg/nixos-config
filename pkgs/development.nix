{ config, pkgs, ... }:
let
in
{
  #
  # development tool
  #
  extraPackages = with pkgs; [
    at-spi2-core.dev
    clang
    cmake
    dart
    dbus.dev
    flutter
    gtk3
    libdatrie
    libepoxy.dev
    libselinux
    libsepol
    libthai
    libxkbcommon
    ninja
    pcre
    pkg-config
    util-linux.dev
    xorg.libXdmcp
    xorg.libXtst

    gnumake
    xorg.libX11
    xorg.libX11.dev
    xorg.libXft
    xorg.libXinerama

    zlib
    xz # libzima

    # go
    go

    # rust openssl
    rustup
    openssl
    expat
    fontconfig

    # desktop
    # flutter
    # dart

    # js/ts
    nodejs-16_x
    yarn
    nodePackages.pnpm
    deno

    # python
    python310
    poetry

    # java
    maven
    # this doesn't automatically add JAVA_HOME to the environment
    # latest jdk for vscode java lsp, jdk17 on write,
    jdk17

    # haskell
    stack
    # haskellPackages.ghcup
    # haskellPackages.hls
  ];

  environment.variables = {
    LD_LIBRARY_PATH = "${pkgs.libepoxy}/lib";
  };
}
