{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraConfig = ''
      luafile ${./nvim.lua}
      let g:polyglot_disabled = ['autoindent']
      set number relativenumber
      " show existing tab with 4 spaces width
      set tabstop=4
      " when indenting with '>', use 4 spaces width
      set shiftwidth=4
      " On pressing tab, insert 4 spaces
      set expandtab

      colorscheme codedark
    '';
    withPython3 = true;

    # coc = {
    #   enable = true;
    #   settings = {
    #     languageserver = {
    #       haskell = {
    #         command = "haskell-language-server-wrapper";
    #         args = [ "--lsp" ];
    #         rootPatterns = [
    #           "*.cabal"
    #           "cabal.project"
    #           "hie.yaml"
    #         ];
    #         filetypes = [ "haskell" "lhaskell" ];
    #       };
    #     };
    #   };
    # };

    plugins = with pkgs.vimPlugins; [
      # coc-nvim

      # coc-python
      # coc-go
      # coc-rust-analyzer

      # coc-toml
      # coc-yaml
      # coc-json

      # coc-highlight

      nvim-tree-lua

      nvim-lspconfig

      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp
      lspkind-nvim

      cmp-vsnip
      vim-vsnip

      vim-code-dark

      toggleterm-nvim

      rust-tools-nvim

      nvim-treesitter
      nvim-autopairs
      indent-blankline-nvim
      # vimExtraPlugins.github-nvim-theme
      # config.nur.repos.m15a.vimExtraPlugins.github-nvim-theme
      # rust-tools

      # Language support
      # vim-nix
      # haskell-vim
      # pkgs.vimPlugins.nvim-tree-lua
      # {
      #   plugin = pkgs.vimPlugins.vim-startify;
      #   config = "let g:startify_change_to_vcs_root = 0";
      # }
    ];
    extraPackages = with pkgs; [
      (python3.withPackages (ps: with ps; [
        black
        # flake8
      ]))
    ];
    extraPython3Packages = (ps: with ps; [
      jedi
    ]);
    # plugins = [
    # ];
  };
}
