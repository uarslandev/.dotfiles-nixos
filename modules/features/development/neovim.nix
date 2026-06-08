{ self, inputs, ... }:

{
  flake.nixosModules.neovim = { pkgs, ... }:

  let
    # 1. Define the configuration using neovimUtils
    neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
      withPython3 = true;
      withNodeJs = true;
      
      # Plugins MUST go here so the wrapper handles their paths correctly
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

      # This is the correct place for your custom Lua configuration
      customRC = ''
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
        require("nvim-treesitter.configs").setup {
          highlight = { enable = true },
          indent = { enable = true },
        }

        -- ========================
        -- LSP
        -- ========================
        local lspconfig = require("lspconfig")

        lspconfig.pyright.setup {}
        lspconfig.rust_analyzer.setup {}
        lspconfig.nil_ls.setup {}

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

    # 2. Pass the generated config and wrapper arguments to wrapNeovimUnstable
    nvim = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (neovimConfig // {
      wrapperArgs = [
        "--set"
        "NVIM_APPNAME"
        "nvim"
      ];
    });

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