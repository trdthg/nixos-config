{ config, pkgs, ... }:
let
  my-python-packages = p: with p; [
    requests
    flake8
    # other python packages
  ];
in
{
  #
  # development tool
  #

  extraPackages = with pkgs; [
    # zlib
    # xz # libzima

    # nix
    rnix-lsp

    # bash
    nodePackages.bash-language-server
    shellcheck

    # c
    gcc
    gdb
    clang
    clang-tools
    lldb

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
    nodePackages.typescript
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
