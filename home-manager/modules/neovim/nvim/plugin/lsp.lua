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
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }
      
      -- Enable completion with more trigger characters
      vim.lsp.completion.enable(true, client.id, ev.buf, { 
        autotrigger = true,
        triggerCharacters = { '.', ':', '-', '"', "'", '/', '@', '*', '=', '<', '>', '(', '[', '{' },
      })
      
      -- Manual trigger
      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end, { buffer = ev.buf })

      -- Enter to accept completion
      vim.keymap.set('i', '<CR>', function()
        if vim.fn.pumvisible() == 1 then
          return vim.fn.complete_info({'selected'}).selected ~= -1 and '<C-y>' or '<C-e><CR>'
        else
          return '\r'
        end
      end, { expr = true, buffer = ev.buf })

      -- Auto-trigger completion when typing words
      local augroup = vim.api.nvim_create_augroup('LspCompletion_' .. ev.buf, {})
      vim.api.nvim_create_autocmd('TextChangedI', {
        group = augroup,
        buffer = ev.buf,
        callback = function()
          local line = vim.fn.getline('.')
          local col = vim.fn.col('.')
          local before_cursor = line:sub(1, col - 1)
          
          -- Trigger completion when typing letters (word characters)
          if before_cursor:match('%w$') then
            vim.defer_fn(function()
              if vim.fn.pumvisible() == 0 then
                vim.lsp.completion.get({ triggerKind = vim.lsp.protocol.CompletionTriggerKind.Invoked })
              end
            end, 100) -- Small delay to allow typing
          end
        end
      })
    end
  end,
})

-- Diagnostics
vim.diagnostic.config({
  virtual_lines = {
    current_line = true,
  },
})
