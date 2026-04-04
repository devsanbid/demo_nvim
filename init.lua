-- ============================================================================
-- Neovim Configuration
-- ============================================================================
-- Main entry point - loads core settings and plugins
-- Structure:
--   lua/core/     - Core Neovim settings (options, keymaps, autocmds)
--   lua/plugins/  - Plugin configurations organized by category
-- ============================================================================

-- Load core configurations
require("core.options")   -- Vim options and settings
require("core.keymaps")   -- Keybindings
require("core.autocmds")  -- Autocommands

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins from lua/plugins/ directory
-- Each file in lua/plugins/ will be automatically loaded
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
