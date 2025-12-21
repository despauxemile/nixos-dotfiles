return {
    "lewis6991/gitsigns.nvim",
    opts = {
        current_line_blame = true,
    },
    config = function()
        vim.keymap.set({ "n", "v" }, "<leader>gp", ":Gitsigns preview_hunk<CR>")
        vim.keymap.set({ "n", "v" }, "<leader>gP", ":Gitsigns preview_hunk_inline<CR>")
        vim.keymap.set({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
    end
}
