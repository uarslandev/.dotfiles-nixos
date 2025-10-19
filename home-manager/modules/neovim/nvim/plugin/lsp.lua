vim.lsp.enable({
    'clangd',
    'omnisharp',
    'nixd',
    'lua_ls',
    -- 'denols',
    'dockerls',
    -- 'graphql',
    -- 'haskell-language-server',
    -- 'java_language_server',
    'html',
    'cssls',
    'jsonls',
    'eslint',
    'kotlin_language_server',
    -- 'lua_ls',
    -- 'marksman',
    'pyright',
    -- 'sqlls',
    -- 'texlab',
    'ts_ls',
    -- 'volar',
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end)
    end
  end,
})

-- Diagnostics
vim.diagnostic.config({
  -- Use the default configuration
  -- virtual_lines = true

  -- Alternatively, customize specific options
  virtual_lines = {
    -- Only show virtual line diagnostics for the current cursor line
    current_line = true,
  },
})
