-- ~/.config/nvim/lua/plugins/dap.lua

-- Try to load required modules
local ok_dap, dap = pcall(require, "dap")
if not ok_dap then
  vim.notify("nvim-dap not found", vim.log.levels.WARN)
  return
end

local ok_ui, dapui = pcall(require, "dapui")
if not ok_ui then
  vim.notify("nvim-dap-ui not found", vim.log.levels.WARN)
  return
end

local ok_python, dap_python = pcall(require, "dap-python")
if not ok_python then
  vim.notify("nvim-dap-python not found", vim.log.levels.WARN)
  return
end

local ok_vtext, dap_vtext = pcall(require, "nvim-dap-virtual-text")
if ok_vtext then
  dap_vtext.setup({ commented = true })
end

-- Setup DAP UI
dapui.setup({})
dap_python.setup("python3")

-- Define signs for breakpoints and stopped state
vim.fn.sign_define("DapBreakpoint", {
  text = "",
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = "",
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapStopped", {
  text = "",
  texthl = "DiagnosticSignWarn",
  linehl = "Visual",
  numhl = "DiagnosticSignWarn",
})

-- Automatically open/close DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Keymaps
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)
vim.keymap.set("n", "<leader>dc", dap.continue, opts)
vim.keymap.set("n", "<leader>do", dap.step_over, opts)
vim.keymap.set("n", "<leader>di", dap.step_into, opts)
vim.keymap.set("n", "<leader>dO", dap.step_out, opts)
vim.keymap.set("n", "<leader>dq", dap.terminate, opts)
vim.keymap.set("n", "<leader>du", dapui.toggle, opts)

