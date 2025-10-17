-- Floating terminal
local status_ok, floaterm = pcall(require, "vim-floaterm")
if not status_ok then
    return
end

-- global keymaps
vim.g.floaterm_keymap_new    = '<leader>ts'
vim.g.floaterm_keymap_prev   = '<leader>tp'
vim.g.floaterm_keymap_next   = '<leader>tn'
vim.g.floaterm_keymap_toggle = '<leader>tt'

-- keymap helper
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Python-specific Floaterm mappings
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
        map('n', '<F5>', ':w<CR>:FloatermNew --autoclose=0 python3 %<CR>', opts)
        map('i', '<F5>', '<ESC>:w<CR>:FloatermNew --autoclose=0 python3 %<CR>', opts)
        map('n', '<leader>tr', ':w<CR>:FloatermNew --autoclose=0 python3 %<CR>', opts)
    end
})

