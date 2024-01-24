{ config, pkgs, ... }:

{
  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    enable = true;
    extraConfig = ''
      set number relativenumber
      set tabstop=4
      set shiftwidth=4
      set softtabstop=4
      set autoindent
    '';
	plugins = [
	  pkgs.vimPlugins.nvim-tree-lua
	  pkgs.vimPlugins.nvim-colorizer-lua
	  pkgs.vimPlugins.lsp-format-nvim
	  pkgs.vimPlugins.formatter-nvim
	  {
		plugin = pkgs.vimPlugins.vim-startify;
		config = "let g:startify_change_to_vcs_root = 0";
      }
	];
  };
}
