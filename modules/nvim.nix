{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set number relativenumber
    '';
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      coc-nvim

      coc-python
      coc-go
      coc-rust-analyzer

      coc-toml
      coc-yaml
      coc-json

      coc-highlight
      nvim-tree-lua
      nvim-cmp
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
