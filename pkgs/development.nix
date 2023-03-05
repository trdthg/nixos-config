{ config, pkgs, ... }:
let
in
{
  #
  # development tool
  #

  extraPackages = with pkgs; [
    # zlib
    # xz # libzima

    gcc
    gdb
    clang
    clang-tools

    # go
    go
    gopls

    # rust openssl
    rustup
    rust-analyzer
    # openssl
    # expat
    # fontconfig

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
    pyright
    poetry

    # java
    maven
    # this doesn't automatically add JAVA_HOME to the environment
    # latest jdk for vscode java lsp, jdk17 on write,
    jdk17

    haskell.compiler.ghc924
    hlint
    haskell-language-server
    (haskell-language-server.override {
      supportedGhcVersions = [ "924" ];
    })

    # haskell
    # stack
    # haskellPackages.ghcup
    # haskellPackages.hls

    # (vscode-with-extensions.override {
    #   vscodeExtensions = with vscode-extensions; [
    #     ms-vscode.cpptools
    #     llvm-vs-code-extensions.vscode-clangd
    #   ];
    # })
  ];


}