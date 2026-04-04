-- LSP and Completion Configuration

return {
  -- Mason (LSP installer)
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },

  -- LSP Configuration
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
