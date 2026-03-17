vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        vim.keymap.set("n", "K", vim.lsp.buf.hover)
        vim.keymap.set("n", "<leader>dg", vim.diagnostic.open_float)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
        vim.keymap.set("n", "gr", vim.lsp.buf.references)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
        vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true)
        end

        if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format { async = false }
                end
            })
        end
    end
})

vim.diagnostic.config({
    severity_sort = true,
    -- virtual_text = true,
})

local caps = vim.lsp.protocol.make_client_capabilities()
-- vim.lsp.config("*", {
--     root_markers = { '.git' },
--     capabilities = caps,
-- })

vim.lsp.config['lua_ls'] = {
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
            },
            hint = { enable = true, },
        },
    },
}

-- vim.lsp.config['rust_analyzer'] = {
--     capabilities = caps,
-- }

vim.lsp.enable({
    "lua_ls",
    "clangd",
    "rust_analyzer",
    "zls",
    "nil_ls",
    "omnisharp",
    "ts_ls",
    "tinymist",
    "cssls",
    "html",
    "pyright",
    "jdtls",
})
-- for name, _ in pairs(vim.lsp.config._configs) do
--     if name ~= "*" then
--         vim.lsp.enable(name)
--     end
-- end
-- vim.lsp.enable({ "clangd", "rust_analyzer", "nil_ls" })


-- return {
--     {
--         "mason-org/mason-lspconfig.nvim",
--         opts = {
--             ensure_installed = {  "ts_ls", "zls", "pyright", "tinymist", "svelte", "cssls", "html" },
--         },
--         dependencies = {
--             { "mason-org/mason.nvim", opts = {} },
--         },
--     },
--     {
--         "neovim/nvim-lspconfig",
--         opts = {},
--         config = function()
--         end
--     },
-- }
