return {
  {
    "otter.nvim",
    dep_of = { "quarto-nvim" },
    after = function ()
      require("otter").setup({})
      vim.keymap.set("n", "<leader>oa", function ()
        require("otter").activate({ "r", "python" })
      end, { desc = "otter activate" })
      vim.keymap.set(
        "n",
        "<leader>od",
        require("otter").deactivate,
        { desc = "otter deactivate" }
      )
      require("LSPs.on_attach")()
    end,
  },
  {
    "quarto-nvim",
    ft = { "quarto", "markdown" },
    -- dep_of = { "molten-nvim" },
    after = function ()
      require("quarto").setup({
        lspFeatures = {
          enabled = true,
          languages = { "r", "python" },
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        codeRunner = {
          default_method = "slime",
        },
      })
      vim.keymap.set(
        "n",
        "<localleader>Q",
        ":QuartoActivate<CR>",
        { desc = "quarto activate", silent = true }
      )
      local runner = require("quarto.runner")
      vim.keymap.set(
        "n",
        "<localleader>rc",
        runner.run_cell,
        { desc = "run [c]ell", silent = true }
      )
      vim.keymap.set(
        "n",
        "<localleader>ra",
        runner.run_above,
        { desc = "run cell and [a]bove", silent = true }
      )
      vim.keymap.set(
        "n",
        "<localleader>rA",
        runner.run_all,
        { desc = "run [A]ll cells", silent = true }
      )
      vim.keymap.set(
        "n",
        "<localleader>rl",
        runner.run_line,
        { desc = "run [l]ine", silent = true }
      )
      vim.keymap.set(
        "v",
        "<localleader>r",
        runner.run_range,
        { desc = "[r]un visual range", silent = true }
      )
    end,
  },
}
