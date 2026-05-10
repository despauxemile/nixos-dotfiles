vim.pack.add({
    'https://github.com/ibhagwan/fzf-lua',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.x') },
    'https://github.com/saghen/blink.indent',
    'https://github.com/folke/tokyonight.nvim',
    'https://github.com/folke/todo-comments.nvim',
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/lewis6991/gitsigns.nvim',
    'https://github.com/nvim-mini/mini.pairs',
    'https://github.com/nvim-tree/nvim-tree.lua',
    'https://github.com/nvim-tree/nvim-web-devicons',
})

-- COLORSCHEME
vim.cmd('colorscheme tokyonight-moon')

-- FZF
local fzf = require('fzf-lua')
fzf.setup({
    winopts = {
        height = 0.85,
        width = 0.85,
        preview = {
            layout = 'horizontal'
        }
    }
})
fzf.register_ui_select()

vim.keymap.set('n', '<leader>ff', fzf.files, { desc = "find files" })
vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = "live grep" })
vim.keymap.set('n', '<leader>gs', fzf.git_status, { desc = "git status" })
vim.keymap.set('n', '<leader>gc', fzf.git_commits, { desc = "git commits" })
vim.keymap.set('n', 'gd', fzf.lsp_definitions, { desc = "go to definition" })
vim.keymap.set('n', 'gr', fzf.lsp_references, { desc = "references" })
vim.keymap.set('n', '<leader>ca', fzf.lsp_code_actions, { desc = "code actions" })

-- LSP
vim.keymap.set('n', '<leader>dg', vim.diagnostic.open_float, { desc = "show diagnostics" })
vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = false,
    float = { source = 'if_many' },
    jump = { float = true },
})

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
    "ty",
    "jdtls",
})

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
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

-- TREESITTER
vim.api.nvim_create_autocmd('FileType', {
    callback = function() pcall(vim.treesitter.start) end,
})

require('nvim-treesitter').setup({
    install_dir = vim.fn.stdpath('data') .. '/site'
})
require('nvim-treesitter').install { 'c', 'cpp', 'css', 'erlang', 'html', 'lua', 'rust', 'typst', 'zig' }

-- CMP
require('blink.cmp').setup({
    keymap = { preset = 'default' },
    appearance = { nerd_font_variant = 'mono' },
    completion = { documentation = { auto_show = false } },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
})

-- NVIM TREE
require('nvim-tree').setup({
    sort = {
        sorter = "case_sensitive"
    },
    view = {
        side = 'left',
    },
    renderer = {
        group_empty = true,
    }
})
vim.keymap.set("n", "<leader>n", require('nvim-tree.api').tree.toggle, { desc = 'toggle sidebar' })

require('todo-comments').setup({})
require('lualine').setup({})
require('gitsigns').setup({ current_line_blame = true })
require('mini.pairs').setup({})
