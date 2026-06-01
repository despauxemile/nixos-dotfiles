-- leader
vim.g.mapleader = ' '

-- essentials
local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.scrolloff = 5
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartcase = true
opt.ignorecase = true
opt.signcolumn = 'yes'
opt.termguicolors = true
opt.updatetime = 250
opt.timeoutlen = 800
opt.ttimeoutlen = 50
opt.winborder = "rounded"

opt.autoread = true

opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.undodir = vim.fn.expand("~/.vim/undodir")

-- keymap
local k = vim.keymap
k.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
k.set("n", "n", "nzz")
k.set("n", "N", "Nzz")
k.set("n", "<C-d>", "<C-d>zz")
k.set("n", "<C-u>", "<C-u>zz")

-- visual mode
k.set("v", "J", ":m '>+1<CR>gv=gv")
k.set("v", "K", ":m '<-2<CR>gv=gv")
k.set("v", "<", "<gv")
k.set("v", ">", ">gv")

-- clipboard
k.set({ "n", "v" }, "<leader>y", [["+y]])
k.set("n", "<leader>Y", [["+Y]])

-- performance
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- create parent dir on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local dir = vim.fn.expand('<afile>:p:h')
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, 'p')
        end
    end,
})

-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function() vim.highlight.on_yank() end
})

-- reload on change
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
    command = "if mode() != 'c' | checktime | endif",
    pattern = "*",
})
