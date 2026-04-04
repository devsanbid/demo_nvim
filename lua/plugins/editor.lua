-- Editor Plugins: File explorer, Fuzzy finder, Syntax highlighting, Auto pairs

return {
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
}
