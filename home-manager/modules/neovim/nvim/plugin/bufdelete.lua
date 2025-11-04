local ok, _ = pcall(require, "bufdelete")
if not ok then
  return
end

-- keymap to delete buffer
vim.keymap.set('n', '<C-q>', '<cmd>Bdelete<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-S-q>', '<cmd>qa!<cr>', { noremap = true, silent = true })

