-- basic
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.scrolloff = 5

-- indent
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- visual
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.winborder = "rounded"

-- file
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir");
vim.opt.updatetime = 300
vim.opt.autoread = true
vim.opt.autowrite = false

-- behavior
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.path:append("**")
vim.opt.mouse = "a"
vim.opt.encoding = "UTF-8"

-- remap
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- y to eol
vim.keymap.set("n", "Y", "y$")

-- center searches
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- half page jumps + center
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- move lines up & down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- indent in v
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- copy to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- delete without yank
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- return to last post when file open
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- create parent dir on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local dir = vim.fn.expand('<afile>:p:h')
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, 'p')
        end
    end,
})

-- diff
vim.opt.diffopt:append("linematch:60")

-- performance
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- from nvim-tree.lua docs
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
