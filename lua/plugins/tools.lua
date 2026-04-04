-- Development Tools: Code runner, Flutter tools

return {
  -- Code runner
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
        dart = { "cd $dir &&", "dart run $fileName" },
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
      { "<leader>rr", ":RunCode<cr>",    desc = "run code" },
      { "<leader>rf", ":RunFile<cr>",    desc = "run file" },
      { "<leader>rp", ":RunProject<cr>", desc = "run project" },
      { "<leader>rc", ":RunClose<cr>",   desc = "close" },
    },
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
          enabled = false, -- Hide dev log window
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
      { "<leader>Fs", "<cmd>FlutterRun<cr>",           desc = "Flutter Run" },
      { "<leader>Fr", "<cmd>FlutterReload<cr>",        desc = "Flutter Hot Reload" },
      { "<leader>FR", "<cmd>FlutterRestart<cr>",       desc = "Flutter Hot Restart" },
      { "<leader>Fq", "<cmd>FlutterQuit<cr>",          desc = "Flutter Quit" },
      { "<leader>Fd", "<cmd>FlutterDevices<cr>",       desc = "Flutter Devices" },
      { "<leader>Fe", "<cmd>FlutterEmulators<cr>",     desc = "Flutter Emulators" },
      { "<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", desc = "Flutter Outline" },
      { "<leader>Fl", "<cmd>FlutterLspRestart<cr>",    desc = "Flutter LSP Restart" },
    },
  },
}
