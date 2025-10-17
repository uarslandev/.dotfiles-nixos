-- ~/.config/nvim/lua/plugins/telescope.lua

local ok, telescope = pcall(require, "telescope")
if not ok then
  vim.notify("telescope.nvim not found", vim.log.levels.WARN)
  return
end

-- Setup telescope
telescope.setup({
  defaults = {
    path_display = { "smart" },
  },
})

-- Load fzf extension if available
local ok_fzf, _ = pcall(function() telescope.load_extension("fzf") end)
if not ok_fzf then
  vim.notify("telescope-fzf-native.nvim not found or build failed", vim.log.levels.WARN)
end

-- Keymaps using your preferred bindings
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, {})

