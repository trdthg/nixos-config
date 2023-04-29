let
  pkgs = import <nixpkgs> { };
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    pkgconfig
  ];
  buildInputs = with pkgs;[
    # cargo
  ];
  shellHook = ''
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${
      pkgs.lib.makeLibraryPath  [
        # pkgs.cargo
      ]
    }"'';
}
