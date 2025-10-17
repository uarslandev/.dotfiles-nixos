-- ~/.config/nvim/lua/plugins/lazygit.lua

-- make sure plenary is loaded
local ok_plenary, _ = pcall(require, "plenary")
if not ok_plenary then
  vim.notify("plenary.nvim not found, lazygit.nvim may not work", vim.log.levels.WARN)
  return
end

-- lazygit plugin setup
local ok_lazygit, _ = pcall(require, "lazygit")
if not ok_lazygit then
  return
end

-- optional: define commands manually if needed
-- lazygit.nvim already registers commands like :LazyGit, :LazyGitConfig, etc.
-- you can add custom keymaps if you like:

vim.keymap.set('n', '<Leader>lg', '<cmd>LazyGit<CR>', { noremap = true, silent = true })

