-- Autocommands Configuration

local autocmd = vim.api.nvim_create_autocmd

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
autocmd("LspAttach", {
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
autocmd("BufWritePost", {
  pattern = "*.dart",
  callback = function()
    vim.defer_fn(function()
      vim.cmd("FlutterReload")
    end, 100)
  end,
  desc = "Flutter hot reload on save",
})
