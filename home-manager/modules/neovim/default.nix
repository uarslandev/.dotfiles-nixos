{ config, pkgs, ... }:

{
  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    enable = true;
    extraLuaConfig = ''
    	${builtins.readFile ./nvim/remap.lua}
    	${builtins.readFile ./nvim/luasnip.lua}
    	${builtins.readFile ./nvim/set.lua}
    	${builtins.readFile ./nvim/plugin/colors.lua}
    	${builtins.readFile ./nvim/plugin/fugitive.lua}
    '';
    plugins = with pkgs.vimPlugins; [
	  nvim-tree-lua
	  nvim-colorizer-lua
	  lsp-format-nvim
	  formatter-nvim
	  (nvim-treesitter.withPlugins (p: [
	  	p.tree-sitter-nix
	  	p.tree-sitter-vim
	  	p.tree-sitter-bash
	  	p.tree-sitter-lua
	  	p.tree-sitter-python
	  	p.tree-sitter-json
	  	p.tree-sitter-haskell
	  ]))
	  playground
	  vim-nix
	  lsp-zero-nvim
	  nvim-lspconfig
	  nvim-cmp
	  cmp-nvim-lsp
	  undotree
	  vim-fugitive
	  {
		plugin = pkgs.vimPlugins.vim-startify;
		config = "let g:startify_change_to_vcs_root = 0";
      }
	];
  };
}
