# Neovim Configuration

A modern, modular Neovim configuration with transparent UI, LSP support, and optimized for development.

## Features

- **Modular Structure** - Organized into logical modules for easy maintenance
- **Transparent UI** - Fully transparent background (tabline, statusline, bufferline)
- **LSP Support** - Auto-install language servers with Mason
- **Git Integration** - Branch display in statusline via lualine
- **Auto-completion** - Fast completion with nvim-cmp and snippets
- **Syntax Highlighting** - Treesitter-based highlighting
- **Fuzzy Finding** - Telescope for files and text search
- **Flutter Support** - Integrated Flutter development tools

## Structure

```
~/.config/demo_nvim/
├── init.lua                    # Main entry point
├── lua/
│   ├── core/                   # Core settings
│   │   ├── options.lua         # Vim options
│   │   ├── keymaps.lua         # Keybindings
│   │   └── autocmds.lua        # Autocommands
│   └── plugins/                # Plugin configurations
│       ├── ui.lua              # UI (colorscheme, bufferline, statusline)
│       ├── editor.lua          # Editor (neo-tree, telescope, treesitter)
│       ├── lsp.lua             # LSP and completion
│       └── tools.lua           # Dev tools (code runner, flutter)
```

## Installation

1. **Clone this repository:**
   ```bash
   git clone <your-repo-url> ~/.config/demo_nvim
   ```

2. **Set as your Neovim config:**
   ```bash
   # Option 1: Use NVIM_APPNAME
   export NVIM_APPNAME=demo_nvim
   nvim
   
   # Option 2: Symlink to default location
   ln -s ~/.config/demo_nvim ~/.config/nvim
   ```

3. **Install plugins:**
   - Lazy.nvim will bootstrap automatically on first run
   - LSP servers auto-install when opening relevant files

## Key Bindings

### Leader Key
- `Space` - Leader key

### File Operations
- `<leader>w` - Save file (silent)
- `<leader>q` - Quit
- `<leader>e` - Toggle file explorer (Neo-tree)

### Navigation
- `Ctrl+h/j/k/l` - Move between windows
- `Shift+h/l` - Previous/next buffer
- `<leader>c` - Close buffer
- `Alt+Shift+j/k` - Move 7 lines down/up

### Fuzzy Finding
- `<leader><leader>` - Find files
- `<leader>fw` - Live grep (find word)
- `<leader>fb` - Find buffers

### LSP
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Hover documentation
- `gl` - Show diagnostics
- `<leader>ca` - Code action
- `<leader>rn` - Rename
- `[d` / `]d` - Previous/next diagnostic
- `<leader>lf` - Format file

### Toggles
- `<leader>td` - Toggle diagnostics virtual text

### Code Runner
- `<leader>rr` - Run code
- `<leader>rf` - Run file
- `<leader>rp` - Run project
- `<leader>rc` - Close runner

### Flutter
- `<leader>Fs` - Flutter run
- `<leader>Fr` - Hot reload
- `<leader>FR` - Hot restart
- `<leader>Fq` - Quit
- `<leader>Fd` - Select device
- `<leader>Fe` - Select emulator

## Plugins

### UI
- **kanagawa.nvim** - Colorscheme with transparent background
- **bufferline.nvim** - Buffer tabs
- **lualine.nvim** - Statusline with git branch

### Editor
- **neo-tree.nvim** - File explorer
- **telescope.nvim** - Fuzzy finder
- **nvim-treesitter** - Syntax highlighting
- **nvim-autopairs** - Auto-close brackets

### LSP & Completion
- **mason.nvim** - LSP installer
- **nvim-lspconfig** - LSP configuration
- **nvim-cmp** - Auto-completion
- **LuaSnip** - Snippet engine

### Tools
- **code_runner.nvim** - Run code for multiple languages
- **flutter-tools.nvim** - Flutter development

## Supported Languages

Auto-install LSP servers for:
- Lua, Python, JavaScript, TypeScript, Rust, Go
- HTML, CSS, JSON, YAML, TOML
- C, C++, Zig, Nix, Dart
- And more...

## Customization

### Add New Plugins
Add plugins to the appropriate file in `lua/plugins/`:
- UI-related → `ui.lua`
- Editor features → `editor.lua`
- Language support → `lsp.lua`
- Development tools → `tools.lua`

### Modify Settings
- **Options** → `lua/core/options.lua`
- **Keymaps** → `lua/core/keymaps.lua`
- **Autocommands** → `lua/core/autocmds.lua`

### Change Colorscheme
Edit `lua/plugins/ui.lua` and modify the kanagawa setup or replace with another colorscheme plugin.

## Requirements

- Neovim >= 0.10
- Git
- Node.js (for some LSP servers)
- ripgrep (for telescope live_grep)
- A Nerd Font (optional, for icons)

## License

MIT
