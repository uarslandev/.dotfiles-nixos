vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Auto commands
--vim.cmd([[autocmd VimEnter * NvimTreeOpen]])
--vim.cmd([[autocmd VimEnter * NvimTreeToggle]])
vim.cmd([[autocmd BufWritePre * Prettier]])

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Text and editing
vim.opt.wrap = false
vim.opt.colorcolumn = "80"

-- File management
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- UI
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.guicursor = ""
vim.opt.modifiable = true
