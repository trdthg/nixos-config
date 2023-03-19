{ pkgs ? import <nixpkgs> { } }:

in pkgs.mkShell {
  buildInputs = with pkgs; [
    haskell.compiler.ghc924
    hlint
    haskell-language-server
    (haskell-language-server.override {
      supportedGhcVersions = [ "924" ];
    })
  ];
  #declaring FLUTTER_ROOT
  # FLUTTER_ROOT = pkgs.flutter;

  shellHook = ''
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${
      pkgs.lib.makeLibraryPath  [
      ]
    }"
  '';
}
