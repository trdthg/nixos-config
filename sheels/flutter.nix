let
  pkgs = import <nixpkgs> { };
in
pkgs.mkShell {

  # build
  nativeBuildInputs = with pkgs;[
    wayland
    cmake
    gcc

    pkg-config


    pcre
    pcre2

    # xorg.libX11
    libepoxy.dev
    xorg.libX11.dev
    # xorg.libXft
    # xorg.libXinerama
    harfbuzz
    gtk3
    gtkmm3
    pango.dev
  ];

  # runtime
  buildInputs = with pkgs;[
    wayland
    cmake

    pkg-config

    pcre
    pcre2

    # xorg.libX11
    # xorg.libX11.dev
    # xorg.libXft
    # xorg.libXinerama

    gtk3
    gtkmm3

    at-spi2-core.dev
    # clang
    gcc
    # cmake
    # dart
    # dbus.dev
    # flutter
    # gtk3
    # libdatrie
    libepoxy.dev
    pango.dev
    harfbuzz
    cairo
    gdk-pixbuf
    glib
    # libselinux
    # libsepol
    # libthai
    # libxkbcommon
    # ninja
    # pcre
    # pkg-config
    # util-linux.dev
    # xorg.libXdmcp
    # xorg.libXtst
  ];

  # export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.xorg.libX11.dev}/lib:${pkgs.gtk3}/lib:${pkgs.pango.dev.out}/lib:${pkgs.pcre2}/lib";
  # ${pkgs.pango.dev.out}/lib:${pkgs.glib.out}/lib:${pkgs.gdk-pixbuf.out}/lib:${pkgs.cairo.out}/lib:${pkgs.at-spi2-core.dev.out}/lib:${pkgs.harfbuzz.out}/lib:$LD_LIBRARY_PATH:${pkgs.gtk3}/lib:${pkgs.libepoxy}/lib:${pkgs.pcre2}/lib
  shellHook = ''
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${
      pkgs.lib.makeLibraryPath  [
        pkgs.pango.dev.out
        pkgs.glib.out
        pkgs.gdk-pixbuf.out
        pkgs.cairo.out
        pkgs.at-spi2-core.dev.out
        pkgs.harfbuzz.out
        pkgs.gtk3
        pkgs.libepoxy
        pkgs.pcre2
      ]
    }"
  '';
}
