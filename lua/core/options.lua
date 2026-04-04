-- Neovim Options Configuration

local opt = vim.opt

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Mouse
opt.mouse = ""

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Text wrapping
opt.wrap = false
opt.breakindent = true

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- UI
opt.termguicolors = true
opt.signcolumn = "no"
opt.cursorline = true
opt.guicursor = ""
opt.scrolloff = 999  -- Keep cursor centered

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- File handling
opt.undofile = true

-- Timing
opt.updatetime = 250
opt.timeoutlen = 300
