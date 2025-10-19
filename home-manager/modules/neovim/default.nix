{ config, pkgs, ... }:
let
  floaterm = pkgs.vimUtils.buildVimPlugin {
    name = "vim-floaterm";
    src = pkgs.fetchFromGitHub {
      owner = "voldikss";
      repo = "vim-floaterm";
      rev = "fd4bdd66eca56c6cc59f2119e4447496d8cde2ea";
      hash = "sha256-/J2TN43v3kVgjL4GdXEzfC2TPnu/FlvHbUX8caPdi64=";
    };
  };
in
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
        ${builtins.readFile ./nvim/plugin/telescope.lua}
        ${builtins.readFile ./nvim/plugin/lsp.lua}
        ${builtins.readFile ./nvim/plugin/lazygit.lua}
        ${builtins.readFile ./nvim/plugin/floaterm.lua}
        ${builtins.readFile ./nvim/plugin/bufdelete.lua}
        ${builtins.readFile ./nvim/plugin/nvim-dap.lua}
        ${builtins.readFile ./nvim/plugin/lualine.lua}
        ${builtins.readFile ./nvim/plugin/bufferline.lua}
        ${builtins.readFile ./nvim/plugin/undotree.lua}
        ${builtins.readFile ./nvim/plugin/fugitive.lua}
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
        pls
        lua-language-server
        pyright
        typescript-language-server
        vscode-langservers-extracted
      ];
      plugins = with pkgs.vimPlugins; [
        lsp-format-nvim
        nvim-colorizer-lua
        bufdelete-nvim
        lualine-nvim
        floaterm
        nvim-whichkey-setup-lua
        bufferline-nvim
        lazygit-nvim
        nvim-dap
        nvim-dap-python
        nvim-dap-ui
        nvim-tree-lua
        dressing-nvim
        flutter-tools-nvim
        formatter-nvim
        haskell-vim
        neoformat
        nvim-surround
        auto-pairs
        null-ls-nvim
        omnisharp-extended-lsp-nvim
        plenary-nvim
        catppuccin-nvim
        vim-airline
        vim-prettier
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
        nvim-treesitter.withAllGrammars
        cmp-nvim-lsp
        lsp-zero-nvim
        nvim-cmp
        nvim-lspconfig
        playground
        undotree
        vim-nix
        telescope-nvim
        telescope-fzf-native-nvim
        telescope-fzf-writer-nvim
        vim-fugitive
#	  {
#		plugin = pkgs.vimPlugins.vim-startify;
#		config = "let g:startify_change_to_vcs_root = 0";
#      }
    ];
  };
}
