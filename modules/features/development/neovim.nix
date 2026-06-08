{ self, inputs, ... }: {

  flake.nixosModules.neovim = { pkgs, ... }: {

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      # Disable the module's wrapper logic entirely so it doesn't conflict with our package
      configure = {}; 
    };

    environment.systemPackages = with pkgs; [
      # 1. Build your custom Neovim package directly using wrapNeovimUnstable
      (wrapNeovimUnstable neovim-unwrapped {
        wrapperArgs = [
          "--set" "NVIM_APPNAME" "nvim"
        ];
        config = {
          withPython3 = true;
          withNodeJs = true;
          
          # Pass plugins via the expected attrset layout
          packages.myPlugins = {
            start = [
              telescope-nvim
              plenary-nvim
              nvim-treesitter
              nvim-lspconfig
              nvim-cmp
              cmp-nvim-lsp
              cmp-buffer
              cmp-path
              luasnip
              cmp_luasnip
              nvim-dap
              nvim-dap-python
              toggleterm-nvim
              nvim-tree-lua
              gitsigns-nvim
            ];
          };

          # Inject pure Lua cleanly into the wrapper's startup mechanism
          customRC = ''
            lua << EOF
            -- ========================
            -- Basic settings
            -- ========================
            vim.opt.number = true
            vim.opt.relativenumber = true
            vim.opt.tabstop = 2
            vim.opt.shiftwidth = 2
            vim.opt.expandtab = true
            vim.opt.smartindent = true
            vim.cmd("syntax on")
            vim.cmd("filetype plugin indent on")

            local opts = { noremap = true, silent = true }

            -- ========================
            -- Telescope
            -- ========================
            require("telescope").setup{}
            vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, opts)
            vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, opts)
            vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, opts)
            vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, opts)

            -- ========================
            -- Tree-sitter
            -- ========================
            require("nvim-treesitter.configs").setup({
              highlight = { enable = true },
              indent = { enable = true },
            })

            -- ========================
            -- LSP setup
            -- ========================
            local lspconfig = require("lspconfig")
            lspconfig.pyright.setup{}
            lspconfig.rust_analyzer.setup{}
            lspconfig.nil_ls.setup{}

            -- ========================
            -- Completion
            -- ========================
            local cmp = require("cmp")
            cmp.setup({
              mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
              }),
              sources = {
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
              }
            })

            -- ========================
            -- Nvim Tree
            -- ========================
            require("nvim-tree").setup()
            vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', opts)

            -- ========================
            -- ToggleTerm
            -- ========================
            require("toggleterm").setup({ direction = "float" })
            vim.keymap.set('n', '<leader>tt', ':ToggleTerm direction=float<CR>', opts)

            -- ========================
            -- Gitsigns
            -- ========================
            require("gitsigns").setup()

            -- ========================
            -- DAP (Python debugging)
            -- ========================
            require("dap-python").setup("python3")
            local dap = require("dap")
            vim.keymap.set('n', '<F5>', dap.continue, opts)
            vim.keymap.set('n', '<F10>', dap.step_over, opts)
            vim.keymap.set('n', '<F11>', dap.step_into, opts)
            EOF
          '';
        };
      })

      # Dependencies & toolchains
      ripgrep
      fd
      git
      gcc
      python3
      tree-sitter
      pyright
      rust-analyzer
      nil
    ];
  };
}