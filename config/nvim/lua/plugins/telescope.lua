return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })

            vim.keymap.set("n", "<leader>fd", builtin.lsp_definitions)
            vim.keymap.set("n", "<leader>fD", builtin.diagnostics)
            vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations)
            vim.keymap.set("n", "<leader>fr", builtin.lsp_references)
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({})
                    }
                }
            })
            require("telescope").load_extension("ui-select")
        end
    }
}
