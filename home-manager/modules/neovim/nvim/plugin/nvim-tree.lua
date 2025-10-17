local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvim_tree.setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true,
            update_root = true,
        },
    })

    -- custom mappings
    vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
    vim.keymap.set('n', '<C-d>', api.tree.change_root_to_node,        opts('Down'))
    vim.keymap.set("n", "<leader>v", function()
        api.node.open.vertical()
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>h", function()
        api.node.open.horizontal()
    end, { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', { })
    vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
end

-- pass to setup along with your other options
require("nvim-tree").setup {
    ---
    on_attach = my_on_attach,
    ---
}
