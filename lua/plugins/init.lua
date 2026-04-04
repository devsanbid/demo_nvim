return {

  {
    "CRAG666/code_runner.nvim",
    opts = {
      filetype = {
        java = {
          "cd $dir &&",
          "java $fileName",
        },
        fish = "fish",
        bash = "bash",
        python = "uv run $fileName",
        typescript = "bun",
        javascript = "bun",
        dart = {"cd $dir &&","dart run $fileName"},
        reactjavascript = "bun",
        go = "go run $fileName",
        c = {
          "cdx $dir &&",
          "gcc $fileName",
          "-o $dir/$fileNameWithoutExt.out &&",
          "$dir/$fileNameWithoutExt.out",
        },
        cpp = {
          "cdx $dir &&",
          "g++ $fileName",
          "-o $dir/$fileNameWithoutExt.out &&",
          "$dir/$fileNameWithoutExt.out",
        },

        typescriptreact = "bun",
        rust = "cargo run -q",
        markdown = {
          "slides",
        },
      },
    },
    keys = {
      { "<leader>r",  desc = "Code runner" },
      { "<leader>rr", ":RunCode<cr>",      desc = "run code" },
      { "<leader>rf", ":RunFile<cr>",      desc = "run file" },
      { "<leader>rp", ":RunProject<cr>",   desc = "run project" },
      { "<leader>rc", ":RunClose<cr>",     desc = "close" },
    },
  },
  -- Colorscheme (fast and minimal) with transparent background
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        transparent = true,
        theme = "wave",
        background = { dark = "wave", light = "lotus" },
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
        overrides = function(colors)
          return {
            -- Remove bold from all common highlight groups
            ["@keyword"] = { bold = false },
            ["@keyword.function"] = { bold = false },
            ["@keyword.return"] = { bold = false },
            ["@keyword.operator"] = { bold = false },
            ["@conditional"] = { bold = false },
            ["@repeat"] = { bold = false },
            ["@exception"] = { bold = false },
            ["@type.builtin"] = { bold = false },
            ["@constant.builtin"] = { bold = false },
            ["@function.builtin"] = { bold = false },
            ["@variable.builtin"] = { bold = false },
            ["@storageclass"] = { bold = false },
            ["@namespace"] = { bold = false },
            ["@include"] = { bold = false },
            ["@boolean"] = { bold = false },
            ["@define"] = { bold = false },
            ["@preproc"] = { bold = false },
            Keyword = { bold = false },
            Statement = { bold = false },
            Conditional = { bold = false },
            Repeat = { bold = false },
            Exception = { bold = false },
            StorageClass = { bold = false },
            Structure = { bold = false },
            Typedef = { bold = false },
            Special = { bold = false },
            Type = { bold = false },
            Boolean = { bold = false },
            Function = { bold = false },
            Identifier = { bold = false },
            Include = { bold = false },
            Define = { bold = false },
            PreProc = { bold = false },
            Title = { bold = false },
          }
        end,
      })
      vim.cmd.colorscheme("kanagawa")
      -- Extra transparency settings
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none", bold = false })
      -- Transparent tabline
      vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
      vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
      vim.api.nvim_set_hl(0, "TabLineSel", { bg = "none" })
      -- Subtle border for completion menu
      vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#3b3b4d", bg = "none" })
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1a1a22" })
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#2d2d3d" })
    end,
  },

  -- Statusline with git support
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      -- Custom transparent theme
      local colors = {
        fg = "#c8c8d8",
        bg = "none",
        branch = "#7aa2f7",
        dimmed = "#7a7a9a",
      }

      local transparent_theme = {
        normal = {
          a = { fg = colors.branch, bg = colors.bg },
          b = { fg = colors.branch, bg = colors.bg },
          c = { fg = colors.fg, bg = colors.bg },
          x = { fg = colors.dimmed, bg = colors.bg },
          y = { fg = colors.dimmed, bg = colors.bg },
          z = { fg = colors.branch, bg = colors.bg },
        },
        insert = {
          a = { fg = colors.branch, bg = colors.bg },
          b = { fg = colors.branch, bg = colors.bg },
          c = { fg = colors.fg, bg = colors.bg },
          x = { fg = colors.dimmed, bg = colors.bg },
          y = { fg = colors.dimmed, bg = colors.bg },
          z = { fg = colors.branch, bg = colors.bg },
        },
        visual = {
          a = { fg = colors.branch, bg = colors.bg },
          b = { fg = colors.branch, bg = colors.bg },
          c = { fg = colors.fg, bg = colors.bg },
          x = { fg = colors.dimmed, bg = colors.bg },
          y = { fg = colors.dimmed, bg = colors.bg },
          z = { fg = colors.branch, bg = colors.bg },
        },
        replace = {
          a = { fg = colors.branch, bg = colors.bg },
          b = { fg = colors.branch, bg = colors.bg },
          c = { fg = colors.fg, bg = colors.bg },
          x = { fg = colors.dimmed, bg = colors.bg },
          y = { fg = colors.dimmed, bg = colors.bg },
          z = { fg = colors.branch, bg = colors.bg },
        },
        command = {
          a = { fg = colors.branch, bg = colors.bg },
          b = { fg = colors.branch, bg = colors.bg },
          c = { fg = colors.fg, bg = colors.bg },
          x = { fg = colors.dimmed, bg = colors.bg },
          y = { fg = colors.dimmed, bg = colors.bg },
          z = { fg = colors.branch, bg = colors.bg },
        },
        inactive = {
          a = { fg = colors.dimmed, bg = colors.bg },
          b = { fg = colors.dimmed, bg = colors.bg },
          c = { fg = colors.dimmed, bg = colors.bg },
          x = { fg = colors.dimmed, bg = colors.bg },
          y = { fg = colors.dimmed, bg = colors.bg },
          z = { fg = colors.dimmed, bg = colors.bg },
        },
      }

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = transparent_theme,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = {},
          lualine_b = {
            {
              "branch",
              icon = "",
            },
          },
          lualine_c = {
            {
              "filename",
              path = 1,  -- relative path
            },
          },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_lsp" },
              symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
            },
          },
          lualine_y = {
            "filetype",
          },
          lualine_z = {
            "location",
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = {},
      })

      -- Ensure transparent background for statusline
      vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
      vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
    end,
  },

  -- Buffer tabs
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    opts = {
      options = {
        mode = "buffers",
        separator_style = { "", "" },
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_buffer_icons = false,
        diagnostics = false,
        always_show_bufferline = true,
        indicator = {
          icon = "▎",
          style = "icon",
        },
        offsets = {
          {
            filetype = "neo-tree",
            text = "",
            separator = false,
          },
        },
        tab_size = 15,
        max_name_length = 20,
        truncate_names = true,
      },
      highlights = {
        fill = { bg = "none" },
        background = { bg = "none", fg = "#5c5c7a" },
        buffer_visible = { bg = "none", fg = "#7a7a9a" },
        buffer_selected = { bg = "none", fg = "#c8c8d8", bold = false, italic = false },
        separator = { bg = "none", fg = "none" },
        separator_visible = { bg = "none", fg = "none" },
        separator_selected = { bg = "none", fg = "none" },
        indicator_visible = { bg = "none", fg = "#5c5c7a" },
        indicator_selected = { bg = "none", fg = "#7aa2f7" },
        modified = { bg = "none", fg = "#5c5c7a" },
        modified_visible = { bg = "none", fg = "#7a7a9a" },
        modified_selected = { bg = "none", fg = "#c8c8d8" },
        tab = { bg = "none" },
        tab_selected = { bg = "none" },
        tab_separator = { bg = "none", fg = "none" },
        tab_separator_selected = { bg = "none", fg = "none" },
        tab_close = { bg = "none" },
      },
    },
  },

  -- Neo-tree (sidebar file explorer)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
    },
    opts = {
      close_if_last_window = true,
      window = {
        width = 30,
        mappings = {
          ["<space>"] = "none",
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
        },
      },
    },
  },

  -- Telescope (fuzzy finder)
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader><leader>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fw",       "<cmd>Telescope live_grep<cr>",  desc = "Find word (grep)" },
      { "<leader>fb",       "<cmd>Telescope buffers<cr>",    desc = "Find buffers" },
    },
    opts = {
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "dist/",
          "build/",
          ".next/",
          "%.lock",
          "package%-lock%.json",
        },
      },
    },
  },

  -- Treesitter (syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    config = function()
      -- Auto close/rename HTML & JSX tags
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true,
        },
      })

      -- Setup treesitter
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- Install parsers (runs async, only installs if missing)
      require("nvim-treesitter").install({
        "python", "lua", "javascript", "typescript", "tsx", "html", "css",
        "json", "yaml", "toml", "bash", "markdown", "markdown_inline",
        "vim", "vimdoc", "query", "rust", "go", "c", "nix", "dart",
      })

      -- Enable treesitter highlighting for all filetypes
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Flutter/Dart development
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("flutter-tools").setup({
        ui = {
          border = "single",
        },
        dev_log = {
          enabled = false,  -- Hide dev log window
        },
        decorations = {
          statusline = {
            app_version = true,
            device = true,
          },
        },
        widget_guides = {
          enabled = true,
        },
        closing_tags = {
          enabled = true,
          highlight = "Comment",
          prefix = "// ",
        },
        lsp = {
          color = {
            enabled = true,
            background = true,
            virtual_text = false,
          },
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            enableSnippets = true,
          },
        },
        debugger = {
          enabled = false,
          run_via_dap = false,
        },
      })
    end,
    keys = {
      { "<leader>Fs", "<cmd>FlutterRun<cr>", desc = "Flutter Run" },
      { "<leader>Fr", "<cmd>FlutterReload<cr>", desc = "Flutter Hot Reload" },
      { "<leader>FR", "<cmd>FlutterRestart<cr>", desc = "Flutter Hot Restart" },
      { "<leader>Fq", "<cmd>FlutterQuit<cr>", desc = "Flutter Quit" },
      { "<leader>Fd", "<cmd>FlutterDevices<cr>", desc = "Flutter Devices" },
      { "<leader>Fe", "<cmd>FlutterEmulators<cr>", desc = "Flutter Emulators" },
      { "<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", desc = "Flutter Outline" },
      { "<leader>Fl", "<cmd>FlutterLspRestart<cr>", desc = "Flutter LSP Restart" },
    },
  },

  -- LSP - AUTO INSTALL servers when opening files
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = false,
      })

      -- LSP server name to Mason package name mapping
      local lsp_to_mason = {
        lua_ls = "lua-language-server",
        ts_ls = "typescript-language-server",
        pyright = "pyright",
        rust_analyzer = "rust-analyzer",
        gopls = "gopls",
        html = "html-lsp",
        cssls = "css-lsp",
        jsonls = "json-lsp",
        clangd = "clangd",
        zls = "zls",
        svelte = "svelte-language-server",
        volar = "vue-language-server",
        intelephense = "intelephense",
        solargraph = "solargraph",
        jdtls = "jdtls",
        kotlin_language_server = "kotlin-language-server",
        elixirls = "elixir-ls",
        hls = "haskell-language-server",
        ocamllsp = "ocaml-lsp",
        bashls = "bash-language-server",
        yamlls = "yaml-language-server",
        taplo = "taplo",
        nil_ls = "nil",
        dockerls = "dockerfile-language-server",
        terraformls = "terraform-ls",
      }

      -- Filetype to LSP server mapping
      local ft_to_server = {
        lua = "lua_ls",
        python = "pyright",
        javascript = "ts_ls",
        typescript = "ts_ls",
        javascriptreact = "ts_ls",
        typescriptreact = "ts_ls",
        rust = "rust_analyzer",
        go = "gopls",
        html = "html",
        css = "cssls",
        json = "jsonls",
        c = "clangd",
        cpp = "clangd",
        zig = "zls",
        svelte = "svelte",
        vue = "volar",
        php = "intelephense",
        ruby = "solargraph",
        java = "jdtls",
        kotlin = "kotlin_language_server",
        elixir = "elixirls",
        haskell = "hls",
        ocaml = "ocamllsp",
        sh = "bashls",
        bash = "bashls",
        yaml = "yamlls",
        toml = "taplo",
        nix = "nil_ls",
        dockerfile = "dockerls",
        terraform = "terraformls",
      }

      -- LSP keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
          end
          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gr", vim.lsp.buf.references, "Go to references")
          map("gl", vim.diagnostic.open_float, "Show diagnostics")
          map("K", vim.lsp.buf.hover, "Hover")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
          map("]d", vim.diagnostic.goto_next, "Next diagnostic")
        end,
      })

      -- Configure and enable lua_ls with Neovim settings
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Enable all LSP servers (they will auto-attach to matching filetypes)
      vim.lsp.enable({
        "lua_ls",
        "pyright",
        "ts_ls",
        "rust_analyzer",
        "gopls",
        "html",
        "cssls",
        "jsonls",
        "clangd",
        "nil_ls",
        "bashls",
        "yamlls",
        "zls",
        "taplo",
      })

      -- Auto-install LSP server when opening a file
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local server = ft_to_server[ft]

          if not server then return end

          local mason_name = lsp_to_mason[server] or server
          local mason_registry = require("mason-registry")

          if not mason_registry.is_installed(mason_name) then
            vim.notify("Installing LSP server: " .. server, vim.log.levels.INFO)
            vim.cmd("MasonInstall " .. mason_name)
          end
        end,
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Load snippets from friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Enable HTML snippets in JSX/TSX
      luasnip.filetype_extend("javascriptreact", { "html" })
      luasnip.filetype_extend("typescriptreact", { "html" })

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        view = {
          entries = {
            follow_cursor = true,
          },
        },
        window = {
          completion = {
            border = "single",
            winhighlight = "Normal:Pmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
            scrollbar = false,
            col_offset = 0,
            side_padding = 1,
          },
          documentation = {
            border = "single",
            winhighlight = "Normal:Pmenu,FloatBorder:CmpBorder",
          },
        },
        formatting = {
          fields = { "abbr", "kind" },
          format = function(_, vim_item)
            -- Simple kind labels without icons
            local kind_labels = {
              Text = "Text",
              Method = "Method",
              Function = "Func",
              Constructor = "Ctor",
              Field = "Field",
              Variable = "Var",
              Class = "Class",
              Interface = "Iface",
              Module = "Mod",
              Property = "Prop",
              Unit = "Unit",
              Value = "Value",
              Enum = "Enum",
              Keyword = "Key",
              Snippet = "Snip",
              Color = "Color",
              File = "File",
              Reference = "Ref",
              Folder = "Dir",
              EnumMember = "Enum",
              Constant = "Const",
              Struct = "Struct",
              Event = "Event",
              Operator = "Op",
              TypeParameter = "Type",
            }
            vim_item.kind = kind_labels[vim_item.kind] or vim_item.kind
            vim_item.menu = nil
            return vim_item
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({ select = true })
              end
            else
              fallback()
            end
          end),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        }),
        sources = {
          { name = "nvim_lsp", max_item_count = 15 },
          { name = "luasnip",  max_item_count = 5 },
          { name = "buffer",   max_item_count = 5 },
          { name = "path",     max_item_count = 5 },
        },
        performance = {
          debounce = 30,
          throttle = 30,
          fetching_timeout = 200,
          max_view_entries = 20,
        },
        experimental = {
          ghost_text = false,
        },
      })
    end,
  },
}
