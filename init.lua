--: Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = ""
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true      -- Copy indent from current line when starting new line
vim.opt.smartindent = true     -- Smart autoindenting for C-like programs
vim.opt.termguicolors = true
vim.opt.signcolumn = "no"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.guicursor = ""
vim.opt.scrolloff = 999  -- Keep cursor centered


-- Basic keymaps
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file", silent = true })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- Window navigation (tmux-style)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })

-- Fast vertical movement
vim.keymap.set("n", "<M-S-j>", "7j", { desc = "Move 7 lines down" })
vim.keymap.set("n", "<M-S-k>", "7k", { desc = "Move 7 lines up" })

-- Buffer navigation
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>c", "<cmd>bwipeout!<cr>", { desc = "Close buffer" })

-- Format
vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format file" })

-- Search word under cursor (Ctrl+n to start, n to find next)
vim.keymap.set("n", "<C-n>", "*N", { desc = "Select word under cursor for search" })

-- Disable all underlines in diagnostics
vim.diagnostic.config({
  underline = false,
  virtual_text = {
    -- Filter out "unused" diagnostics
    format = function(diagnostic)
      -- Hide "declared but never read/used" messages
      local dominated_patterns = {
        "never read",
        "never used",
        "is declared but",
        "is defined but never used",
        "is assigned a value but never used",
        "unused",
      }
      local msg = diagnostic.message:lower()
      for _, pattern in ipairs(dominated_patterns) do
        if msg:find(pattern) then
          return nil
        end
      end
      return diagnostic.message
    end,
  },
  signs = false,
})

-- Remove underlines from LSP semantic highlights
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    -- Disable underlines in all diagnostic highlights
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = false })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = false })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = false })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = false })
    -- Disable underlines in spell checking
    vim.api.nvim_set_hl(0, "SpellBad", { underline = false })
    vim.api.nvim_set_hl(0, "SpellCap", { underline = false })
    vim.api.nvim_set_hl(0, "SpellLocal", { underline = false })
    vim.api.nvim_set_hl(0, "SpellRare", { underline = false })
  end,
})

-- Flutter auto hot reload on save
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.dart",
  callback = function()
    vim.defer_fn(function()
      vim.cmd("FlutterReload")
    end, 100)
  end,
  desc = "Flutter hot reload on save",
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins", {
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "netrwPlugin",
        "tarPlugin", "tohtml", "tutor", "zipPlugin",
      },
    },
  },
})
