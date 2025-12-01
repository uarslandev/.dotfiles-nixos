-- ~/.config/nvim/lua/plugins/lualine.lua

-- check if lualine is installed
local ok, lualine = pcall(require, "lualine")
if not ok then
  vim.notify("lualine.nvim not found", vim.log.levels.WARN)
  return
end


-- setup lualine with custom theme
lualine.setup({
  options = {
    theme = "base16",
  },
})
