{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package =
      pkgs.vscode;
    # pkgs.vscode.fhsWithPackages (ps: with ps; [
    #   rustup
    #   zlib
    #   openssl.dev
    #   pkg-config
    #   cargo
    #   # rust-analyzer
    #   # nix
    # ]);
    extensions = with pkgs.vscode-extensions; [

      arrterian.nix-env-selector

      shardulm94.trailing-spaces
      bierner.markdown-emoji
      # bierner.markdown-preview-github-styles
      # bierner.markdown-prism
      # bierner.markdown-yaml-preamble
      # DavidAnson.vscode-markdownlint
      christian-kohler.path-intellisense


      # cweijan.vscode-database-client2
      # Davidsekar.redis-xplorer

      # bmewburn.vscode-intelephense-client
      # github.copilot

      intellsmi.comment-translate
      # kisstkondoros.vscode-gutter-preview
      # llvm-vs-code-extensions.vscode-clangd
      # maciejdems.add-to-gitignore

      # DotJoshJohnson.xml
      # denoland.vscode-deno
      # justusadam.language-haskell
      # golang.go
      # haskell.haskell
      jnoortheen.nix-ide
      tamasfe.even-better-toml
      mads-hartmann.bash-ide-vscode
      foxundermoon.shell-format
      rust-lang.rust-analyzer
      serayuzgur.crates
      # FractalBoy.pls

      # eamodio.gitlens
      # donjayamanne.githistory

      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      # ms-vscode-remote.vscode-remote-extensionpack
      # ms-vscode.azure-repos
      # ms-vscode.cmake-tools
      # ms-vscode.cpptools
      ms-vscode.hexeditor
      # ms-vscode.remote-repositories
      # ms-vscode.remote-server

      # github.github-vscode-theme
      # equinusocio.vsc-material-theme-icons
      # akamud.vscode-theme-onelight
      # muuvmuuv.vscode-sundial
      # naumovs.color-highlight
      # PKief.material-icon-theme

      # vadimcn.vscode-lldb
      # surajbarkale.ninja

      # wangzy.sneak-mark
      # webfreak.debug
      # espressif.esp-idf-extension
      # pgourlain.erlang
      # slevesque.shader
      # ZixuanWang.linkerscript
      # skellock.just
      # mrorz.language-gettext
      # dtoplak.vscode-glsllint
      # zxh404.vscode-proto3
      # cduruk.thrift
      # alingse.thirft-formatter
      # redhat.vscode-community-server-connector
      # redhat.vscode-rsp-ui

    ];
  };
}
