-- minimal Neovim baseline

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.updatetime = 250

vim.keymap.set("n", "<leader>w", ":write<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", ":quit<CR>", { silent = true })
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })
