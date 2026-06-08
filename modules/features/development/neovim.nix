{ self, inputs, ... }:

{
  flake.nixosModules.neovim = { pkgs, ... }:

  let
    myPlugins = with pkgs.vimPlugins; [
      telescope-nvim
      plenary-nvim

      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path

      luasnip
      cmp_luasnip

      nvim-treesitter.withAllGrammars

      nvim-dap
      nvim-dap-python

      toggleterm-nvim
      nvim-tree-lua
      gitsigns-nvim
    ];

    neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
      withPython3 = true;
      withNodeJs = true;
      plugins = myPlugins;
      
      wrapperArgs = [
        "--set"
        "NVIM_APPNAME"
        "nvim"
      ];

      luaRcContent = ''
        -- Leader MUST be first
        vim.g.mapleader = " "
        vim.g.maplocalleader = " "

        -- ========================
        -- Basic settings
        -- ========================
        vim.opt.number = true
        vim.opt.relativenumber = true
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.expandtab = true
        vim.opt.smartindent = true

        local opts = { noremap = true, silent = true }

        -- ========================
        -- Telescope
        -- ========================
        require("telescope").setup {}

        vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, opts)
        vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, opts)
        vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, opts)
        vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, opts)
      '';
    };

    nvim = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped neovimConfig;

  in
  {
    environment.systemPackages = [
      nvim
      pkgs.ripgrep
      pkgs.fd
      pkgs.git
      pkgs.gcc
      pkgs.python3

      pkgs.pyright
      pkgs.rust-analyzer
      pkgs.nil
    ];

    programs.neovim.enable = false;
  };
}