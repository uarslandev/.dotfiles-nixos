-- ~/.config/nvim/lua/plugins/lualine.lua

-- check if lualine is installed
local ok, lualine = pcall(require, "lualine")
if not ok then
  vim.notify("lualine.nvim not found", vim.log.levels.WARN)
  return
end

-- load the onedark theme
local ok_theme, onedark = pcall(require, "lualine.themes.onedark")
if not ok_theme then
  vim.notify("lualine onedark theme not found", vim.log.levels.WARN)
  return
end

-- custom darker gray color
local darker_gray = '#242424'

local custom_onedark = vim.tbl_deep_extend("force", onedark, {
  normal  = { c = { bg = darker_gray } },
  insert  = { c = { bg = darker_gray } },
  visual  = { c = { bg = darker_gray } },
  replace = { c = { bg = darker_gray } },
  command = { c = { bg = darker_gray } },
})

-- setup lualine with custom theme
lualine.setup({
  options = {
    theme = custom_onedark,
  },
})

