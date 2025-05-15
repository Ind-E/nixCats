return {
  {
    "nvim-lint",
    event = "FileType",
    after = function(plugin)
      require('lint').linters_by_ft = {
        bash = { "shellcheck" },
        nix = { "statix", "deadnix" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
