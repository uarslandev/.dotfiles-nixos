require'nvim-treesitter.configs'.setup {
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false,

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<C-Space>',
            node_incremental = '<C-Space>',
            scope_incremental = false,
            node_decremental = '<bs>',
        },
    },
--    ensure_installed = { "tsx", "typescript", "javascript", "html", "css" }, -- parsers you want
    highlight = {
        enable = true,              -- enable treesitter highlighting
        additional_vim_regex_highlighting = false,  -- optional: disable default syntax
    },
    indent = {
        enable = true,
    },
}
