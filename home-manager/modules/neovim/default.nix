{ config, pkgs, ... }:

{
  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    enable = true;
    extraLuaConfig = ''
    	${builtins.readFile ./nvim/remap.lua}
    '';
    plugins = [
	  pkgs.vimPlugins.nvim-tree-lua
	  pkgs.vimPlugins.nvim-colorizer-lua
	  pkgs.vimPlugins.lsp-format-nvim
	  pkgs.vimPlugins.formatter-nvim
	  pkgs.vimPlugins.nvim-treesitter
	  pkgs.vimPlugins.playground
	  pkgs.vimPlugins.lsp-zero-nvim
	  pkgs.vimPlugins.nvim-lspconfig
	  pkgs.vimPlugins.nvim-cmp
	  pkgs.vimPlugins.cmp-nvim-lsp
	  pkgs.vimPlugins.undotree
	  pkgs.vimPlugins.vim-fugitive
	  {
		plugin = pkgs.vimPlugins.vim-startify;
		config = "let g:startify_change_to_vcs_root = 0";
      }
	];
  };
}
