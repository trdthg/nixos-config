{ config, pkgs, ... }:
let
in
{
  #
  # development tool
  #
  extraPackages = with pkgs; [
    pkg-config
    zlib

    # go
    go

    # rust openssl
    rustup
    openssl
    expat
    fontconfig

    # desktop
    flutter
    dart

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
}
