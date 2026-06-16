vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.wrap = false
vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.cursorline = true
vim.opt.scrolloff = 3
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"

vim.opt.termguicolors = true

-- Leader
vim.g.mapleader = " "

-- Tab settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true

-- Search and highlighting
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- History
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.fn.mkdir(vim.o.undodir, "p")

-- Keymap
vim.keymap.set("n", "<tab><tab>", ":b#<CR>")
vim.keymap.set("n", "<tab>n", ":bn<CR>")
vim.keymap.set("n", "<tab>p", ":bp<CR>")

vim.keymap.set("n", "<tab>h", "<C-w>h")
vim.keymap.set("n", "<tab>j", "<C-w>j")
vim.keymap.set("n", "<tab>k", "<C-w>k")
vim.keymap.set("n", "<tab>l", "<C-w>l")

vim.keymap.set("n", "<C-->", ":split<CR>")
vim.keymap.set("n", "<C-\\>", ":vsplit<CR>")

vim.keymap.set("n", "<C-h>", ":vertical resize -5<CR>")
vim.keymap.set("n", "<C-j>", ":resize -3<CR>")
vim.keymap.set("n", "<C-k>", ":resize +3<CR>")
vim.keymap.set("n", "<C-l>", ":vertical resize +5<CR>")
