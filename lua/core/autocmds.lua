-- Autocommands Configuration

local autocmd = vim.api.nvim_create_autocmd

-- Store diagnostic virtual text formatter for toggling
_G.diagnostic_virtual_text_format = function(diagnostic)
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
end

-- Persistent state management for diagnostics
local state_file = vim.fn.stdpath("data") .. "/diagnostics_state.json"

-- Load diagnostics state from file
local function load_diagnostics_state()
  local file = io.open(state_file, "r")
  if file then
    local content = file:read("*all")
    file:close()
    local ok, state = pcall(vim.json.decode, content)
    if ok and state then
      return state
    end
  end
  -- Default state: virtual text enabled
  return { virtual_text_enabled = true }
end

-- Save diagnostics state to file
_G.save_diagnostics_state = function(state)
  local file = io.open(state_file, "w")
  if file then
    file:write(vim.json.encode(state))
    file:close()
  end
end

-- Load and apply saved state
local saved_state = load_diagnostics_state()

-- Configure diagnostics based on saved state
vim.diagnostic.config({
  underline = false,
  virtual_text = saved_state.virtual_text_enabled and {
    format = _G.diagnostic_virtual_text_format,
  } or false,
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
