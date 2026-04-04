-- UI Plugins: Colorscheme, Bufferline, Statusline

return {
  -- Colorscheme (Kanagawa with transparent background)
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
}
