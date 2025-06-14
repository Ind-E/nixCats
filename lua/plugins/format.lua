return {
  {
    "conform.nvim",
    after = function (plugin)
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          bash = { "shfmt" },
          nix = { "nixfmt" },
          rust = { "rustfmt" },
          qml = { "qmlformat" },
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>lf", function ()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "[f]ormat" })
    end,
  },
}
