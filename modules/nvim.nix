{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraConfig = ''
      luafile ${./nvim.lua}

      " 缩进
      let g:polyglot_disabled = ['autoindent']

      set number relativenumber
      " show existing tab with 4 spaces width
      set tabstop=4
      " when indenting with '>', use 4 spaces width
      set shiftwidth=4
      " On pressing tab, insert 4 spaces
      set expandtab

      " 颜色，图标... 主题
      colorscheme codedark

      " 空白字符高亮
      hi TrailSpace ctermbg=blue ctermfg=red guibg=red
      match TrailSpace /\s\+$/
      set list
      set listchars=tab:>\ ,trail:-,nbsp:+
      "set listchars=tab:>\ ,trail:-,nbsp:+,eol:$
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

      # 语法树解析器
      nvim-treesitter
      # 自动括号
      nvim-autopairs
      # 自动缩进
      indent-blankline-nvim
      # 自动保存
      auto-save-nvim

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
