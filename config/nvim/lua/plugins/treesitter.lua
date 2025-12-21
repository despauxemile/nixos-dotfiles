return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "master",
    build = ":TSUpdate",
    config = function()
        -- master branch
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { 'c', 'cpp', 'css', 'erlang', 'html', 'lua', 'rust', 'typst', 'zig' },
            highlight = { enable = true },
            indent = { enable = true },
        })

        -- new version (main branch), breaks telescope
        -- require 'nvim-treesitter'.install { 'c', 'cpp', 'css', 'erlang', 'html', 'lua', 'rust', 'typst', 'zig' }
        -- vim.treesitter.start()
    end
}
