-- Keymaps Configuration

local keymap = vim.keymap.set

-- File operations
keymap("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file", silent = true })
keymap("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- Window navigation (tmux-style)
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })

-- Fast vertical movement
keymap("n", "<M-S-j>", "7j", { desc = "Move 7 lines down" })
keymap("n", "<M-S-k>", "7k", { desc = "Move 7 lines up" })

-- Buffer navigation
keymap("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
keymap("n", "<leader>c", "<cmd>bwipeout!<cr>", { desc = "Close buffer" })

-- Format
keymap("n", "<leader>lf", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format file" })

-- Search word under cursor
keymap("n", "<C-n>", "*N", { desc = "Select word under cursor for search" })
