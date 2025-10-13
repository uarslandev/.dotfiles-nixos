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
    	${builtins.readFile ./nvim/plugin/lsp.lua}
    	${builtins.readFile ./nvim/plugin/colors.lua}
    	${builtins.readFile ./nvim/plugin/fugitive.lua}
    	${builtins.readFile ./nvim/plugin/telescope.lua}
    	${builtins.readFile ./nvim/plugin/flutter-tools.lua}
    	${builtins.readFile ./nvim/plugin/nvim-tree.lua}
    '';
    extraPackages = with pkgs; [
      ccls
      dockerfile-language-server-nodejs
      haskell-language-server
      kotlin-language-server
      lua-language-server
      luajitPackages.lua-lsp
      markdown-oxide
      mesonlsp
      nixd
      nodePackages.prettier
      pls
      pyright
      typescript-language-server
      vscode-langservers-extracted
    ];
    plugins = with pkgs.vimPlugins; [
	  nvim-tree-lua
      rose-pine
      neoformat
      plenary-nvim
      null-ls-nvim
      dressing-nvim
      omnisharp-extended-lsp-nvim
      vim-prettier
      haskell-vim
	  nvim-colorizer-lua
	  lsp-format-nvim
      formatter-nvim
      flutter-tools-nvim
	  (nvim-treesitter.withPlugins (p: [
	  	p.tree-sitter-nix
	  	p.tree-sitter-javascript
	  	p.tree-sitter-tsx
	  	p.tree-sitter-typescript
	  	p.tree-sitter-json5
        p.tree-sitter-vim
	  	p.tree-sitter-bash
	  	p.tree-sitter-lua
	  	p.tree-sitter-python
	  	p.tree-sitter-json
	  	p.tree-sitter-haskell
      ]))
#      nvim-treesitter.withAllGrammars
	  playground
	  vim-nix
	  lsp-zero-nvim
	  nvim-lspconfig
	  nvim-cmp
	  cmp-nvim-lsp
	  undotree
      vim-fugitive
      telescope-nvim
#	  {
#		plugin = pkgs.vimPlugins.vim-startify;
#		config = "let g:startify_change_to_vcs_root = 0";
#      }
	];
  };
}
