{ self, inputs, ... }:

{
  perSystem =
    { pkgs, ... }:
    let
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
        vim.opt.clipboard = "" 
        vim.opt.timeoutlen = 300 -- Faster popup time for Which-Key

        -- ========================
        -- Noctalia Color Scheme Sync
        -- ========================
        local watch_dir = "/home/umut/.config/noctalia"
        local function load_noctalia_colors()
          local f = io.open(watch_dir .. "/colors.json", "r")
          if not f then return end
          local content = f:read("*a")
          f:close()
          local ok, colors = pcall(vim.json.decode, content)
          if not ok then return end

          vim.api.nvim_set_hl(0, "Normal", { bg = colors.mSurface, fg = colors.mOnSurface })
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.mSurfaceVariant or colors.mSurface, fg = colors.mOnSurface })
          vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.mPrimary })
          vim.api.nvim_set_hl(0, "Visual", { bg = colors.mSurfaceVariant or colors.mHover })
          vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.mSurfaceVariant })

          vim.api.nvim_set_hl(0, "Comment", { fg = colors.mOnSurfaceVariant or "#7f8c8d", italic = true })
          vim.api.nvim_set_hl(0, "Constant", { fg = colors.mSecondary })
          vim.api.nvim_set_hl(0, "String", { fg = colors.mTertiary })
          vim.api.nvim_set_hl(0, "Identifier", { fg = colors.mOnSurface })
          vim.api.nvim_set_hl(0, "Function", { fg = colors.mPrimary })
          vim.api.nvim_set_hl(0, "Statement", { fg = colors.mPrimary, bold = true })
          vim.api.nvim_set_hl(0, "Operator", { fg = colors.mOutline })
          vim.api.nvim_set_hl(0, "PreProc", { fg = colors.mPrimary })
          vim.api.nvim_set_hl(0, "Type", { fg = colors.mSecondary })
          vim.api.nvim_set_hl(0, "Structure", { fg = colors.mSecondary })
          vim.api.nvim_set_hl(0, "Special", { fg = colors.mTertiary })
          vim.api.nvim_set_hl(0, "Error", { fg = colors.mError })
          vim.api.nvim_set_hl(0, "Todo", { fg = colors.mHover, bold = true })

          vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.mPrimary })
          vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = colors.mPrimary })
          vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = colors.mPrimary })
          vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = colors.mPrimary })
          vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = colors.mSurfaceVariant })
        end

        load_noctalia_colors()

        local uv = vim.uv or vim.loop
        local watcher = uv.new_fs_event()
        watcher:start(watch_dir, {}, vim.schedule_wrap(function(err, fname, status)
          if err then return end
          if fname == "colors.json" then
            load_noctalia_colors()
          end
        end))

        local opts = { noremap = true, silent = true }

        -- ========================
        -- Requested Custom Keymaps
        -- ========================

        -- Copy/Yank to System Clipboard
        vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = "Yank to system clipboard" })
        vim.keymap.set('n', '<leader>Y', '"+Y', { desc = "Yank line to system clipboard" })

        vim.keymap.set('n','<leader>p',function() print(vim.fn.expand('%:p')) end)

        -- Move Visual Blocks up/down with J and K
        vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
        vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)

        -- ========================
        -- UI, Rainbow & Discovery Tools
        -- ========================
        require("lualine").setup { options = { theme = "bubble" } }
        require("nvim-autopairs").setup {}
        require("Comment").setup {} -- Capitalized fix applied here
        require("which-key").setup {}

        local rainbow_delimiters = require("rainbow-delimiters")
        vim.g.rainbow_delimiters = {
          strategy = { [""] = rainbow_delimiters.strategy["global"] },
          query = { [""] = "rainbow-delimiters" },
        }

        -- ========================
        -- Telescope
        -- ========================
        require("telescope").setup {
          pickers = {
            find_files = {
              hidden = true,
              find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
            },
          },
        }

        vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = "Find Files" })
        vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = "Live Grep" })
        vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = "Buffers" })
        vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = "Help Tags" })

        -- ========================
        -- Automated Formatting (Conform)
        -- ========================
        require("conform").setup({
          formatters_by_ft = {
            nix = { "nixfmt" },
            python = { "black" },
            rust = { "rustfmt" },
          },
          format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
          },
        })

        -- ========================
        -- Vimtex Configuration
        -- ========================
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_view_use_temp_files = 1

        -- ========================
        -- Treesitter
        -- ========================
        require("nvim-treesitter").setup {
          highlight = {
            enable = true,
            disable = { "latex" }, -- Vimtex handles highlight and indent better for LaTeX
          },
          indent = { enable = true },
        }

        -- ========================
        -- Native Neovim 0.11+ LSP Engine Setup
        -- ========================
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        local custom_on_attach = function(client, bufnr)
          require("lsp_signature").on_attach({}, bufnr)
        end

        local lsp_base_opts = {
          capabilities = capabilities,
          on_attach = custom_on_attach,
        }

        vim.lsp.config('pyright', lsp_base_opts)
        vim.lsp.config('rust_analyzer', lsp_base_opts)
        vim.lsp.config('nil_ls', lsp_base_opts)
        vim.lsp.config('nixd', lsp_base_opts)
        vim.lsp.config('texlab', lsp_base_opts)

        vim.lsp.enable('pyright')
        vim.lsp.enable('rust_analyzer')
        vim.lsp.enable('nil_ls')
        vim.lsp.enable('nixd')
        vim.lsp.enable('texlab')

        -- Global LSP Mappings
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true, desc = "Go to Definition" })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = true, desc = "Hover Documentation" })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = true, desc = "Rename Symbol" })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = true, desc = "Code Action" })

        -- ========================
        -- Completion Engine Configuration
        -- ========================
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup {
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert {
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            ["<CR>"] = cmp.mapping.confirm { select = true },
          },
          sources = {
            { name = "nvim_lsp" }, 
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
          },
        }

        -- ========================
        -- File explorer
        -- ========================
        require("nvim-tree").setup {}
        vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = "Toggle File Explorer" })

        -- ========================
        -- Terminal (vim-floaterm)
        -- ========================
        vim.g.floaterm_width = 0.8
        vim.g.floaterm_height = 0.8
        vim.g.floaterm_title = "Terminal ($1/$2)"

        -- Easy escape from terminal mode to normal mode using double Escape
        vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })

        -- Keymaps to toggle multiple terminals
        vim.keymap.set({'n', 't'}, '<A-t>', '<Cmd>FloatermToggle<CR>', { desc = "Toggle Terminal" })
        vim.keymap.set({'n', 't'}, '<A-n>', '<Cmd>FloatermNew<CR>', { desc = "New Terminal" })
        vim.keymap.set({'n', 't'}, '<A-x>', '<Cmd>FloatermKill<CR>', { desc = "Kill Terminal" })
        vim.keymap.set({'n', 't'}, '<A-j>', '<Cmd>FloatermNext<CR>', { desc = "Next Terminal" })
        vim.keymap.set({'n', 't'}, '<A-k>', '<Cmd>FloatermPrev<CR>', { desc = "Previous Terminal" })

        vim.keymap.set('n', '<leader>tt', '<Cmd>FloatermToggle<CR>', { desc = "Toggle Terminal" })
        vim.keymap.set('n', '<leader>tn', '<Cmd>FloatermNew<CR>', { desc = "New Terminal" })
        vim.keymap.set('n', '<leader>tx', '<Cmd>FloatermKill<CR>', { desc = "Kill Terminal" })

        -- Seamless tab navigation in both normal and terminal mode
        vim.keymap.set({'n', 't'}, '<A-h>', '<Cmd>tabprevious<CR>', { desc = "Go to previous tab" })
        vim.keymap.set({'n', 't'}, '<A-l>', '<Cmd>tabnext<CR>', { desc = "Go to next tab" })

        -- Auto-reopen floaterm showing remaining tabs if one is closed/killed
        vim.api.nvim_create_autocmd("BufDelete", {
          pattern = "*",
          callback = function(args)
            local ok, ft = pcall(vim.api.nvim_get_option_value, "filetype", { buf = args.buf })
            if ok and ft == "floaterm" then
              vim.schedule(function()
                local list = vim.fn['floaterm#buflist#gather']()
                if #list > 0 then
                  vim.cmd("FloatermShow")
                end
              end)
            end
          end
        })

        -- ========================
        -- Git Signs
        -- ========================
        require("gitsigns").setup {}

        -- ========================
        -- DAP (Debugging Framework)
        -- ========================
        require("dap-python").setup("python3")

        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

        vim.keymap.set('n', '<F5>', dap.continue, { desc = "Debug: Continue/Start" })
        vim.keymap.set('n', '<F10>', dap.step_over, { desc = "Debug: Step Over" })
        vim.keymap.set('n', '<F11>', dap.step_into, { desc = "Debug: Step Into" })
        vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
        vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = "Debug: Toggle UI Panels" })
      '';

      plugins = with pkgs.vimPlugins; [
        # Core & UI Essentials
        telescope-nvim
        plenary-nvim
        nvim-web-devicons
        lualine-nvim
        nvim-autopairs
        rainbow-delimiters-nvim
        which-key-nvim

        # Code Manipulation Utilities
        comment-nvim
        conform-nvim

        # LSP Core Tooling
        nvim-lspconfig
        lsp_signature-nvim

        # Completion Engine Stack
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-path

        # Snippets Engine
        luasnip
        cmp_luasnip

        # Treesitter Syntax Parsing
        nvim-treesitter.withAllGrammars

        # Debugging Suite (DAP)
        nvim-dap
        nvim-dap-ui
        nvim-nio
        nvim-dap-python

        # Layout & Tooling Utilities
        vim-floaterm
        nvim-tree-lua
        gitsigns-nvim

        # LaTeX Integration
        vimtex
      ];

      runtimePkgs = [
        # CLI Dependencies
        pkgs.ripgrep
        pkgs.fd
        pkgs.git
        pkgs.gcc
        pkgs.python3

        # Language Server Binaries
        pkgs.pyright
        pkgs.rust-analyzer
        pkgs.nil
        pkgs.nixd
        pkgs.texlab

        # PDF Viewer
        pkgs.zathura

        # Project Code Formatters (Invoked by conform-nvim)
        pkgs.nixfmt
        pkgs.black
      ];
    in
    {
      packages.neovim = inputs.wrapper-modules.wrappers.neovim.wrap {
        inherit pkgs;

        settings.config_directory = pkgs.writeTextDir "init.lua" luaRcContent;

        specs.general = plugins;

        inherit runtimePkgs;

        hosts.python3.nvim-host.enable = true;
        hosts.node.nvim-host.enable = true;
      };
    };

  flake.nixosModules.neovim =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.neovim
      ];

      programs.neovim.enable = false;
    };
}
