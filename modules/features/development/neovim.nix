{ self, inputs, ... }:

{
  flake.nixosModules.neovim = { pkgs, ... }:

  let
    neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
      withPython3 = true;
      withNodeJs = true;
      
      plugins = with pkgs.vimPlugins; [
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

        -- ========================
        -- Treesitter
        -- ========================
        require("nvim-treesitter").setup {
          highlight = { enable = true },
          indent = { enable = true },
        }

        -- ========================
        -- Native Neovim 0.11+ LSP
        -- ========================
        -- Instead of require('lspconfig').setup, we now use vim.lsp.enable
        vim.lsp.enable('pyright')
        vim.lsp.enable('rust_analyzer')
        vim.lsp.enable('nil_ls')

        -- ========================
        -- Completion
        -- ========================
        local cmp = require("cmp")

        cmp.setup {
          mapping = cmp.mapping.preset.insert {
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            ["<CR>"] = cmp.mapping.confirm { select = true },
          },
          sources = {
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
          },
        }

        -- ========================
        -- File explorer
        -- ========================
        require("nvim-tree").setup {}

        vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', opts)

        -- ========================
        -- Terminal
        -- ========================
        require("toggleterm").setup { direction = "float" }

        vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', opts)

        -- ========================
        -- Git
        -- ========================
        require("gitsigns").setup {}

        -- ========================
        -- DAP (Python)
        -- ========================
        require("dap-python").setup("python3")

        local dap = require("dap")

        vim.keymap.set('n', '<F5>', dap.continue, opts)
        vim.keymap.set('n', '<F10>', dap.step_over, opts)
        vim.keymap.set('n', '<F11>', dap.step_into, opts)
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