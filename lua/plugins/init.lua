require("vscode.colors").get_colors()
require("vscode").setup({
  color_overrides = {
    vscBack = "#000000",
    vscCursorDarkDark = "#171717",
    vscLeftDark = "#000000",
    vscPopupBack = "#000000",
  }
})
vim.cmd.colorscheme "vscode"


require("lze").load {
  -- { import = "plugins.completion", },
  -- { import = "plugins.lint", },
  -- { import = "plugins.debug", },
  -- { import = "plugins.format", },
  { import = "plugins.telescope", },
  -- { import = "plugins.treesitter", },
  { import = "plugins.mini", },
  {
    "comment.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("Comment").setup()
    end,
  },
  {
    "lualine.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("lualine").setup({})
    end,
  },
  {
    "gitsigns.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("gitsigns").setup({})
    end,
  },
  {
    "which-key.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("which-key").setup({})
      require("which-key").add {
        { "<leader>b", group = "[b]uffers" },
        { "<leader>g", group = "[g]it" },
      }
    end,
  },
  {
    "auto-save.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("auto-save").setup({});
    end,
  },
  {
    "bufferline.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("bufferline").setup({});
    end,
  },
  {
    "conform.nvim",
    keys = {
      { "<leader>lf", desc = "[f]ormat" },
    },

    after = function(plugin)
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {

        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>lf", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "[f]ormat" })
    end,
  },
  {
    "nvim-lint",
    event = "FileType",
    after = function(plugin)
      require("lint").linters_by_ft = {

      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
  {
    "nvim-colorizer",
    event = "BufReadPre",
    after = function(plugin)
      require("colorizer").setup({
        user_default_options = {
          mode = "virtualtext"
        }
      })
    end,

  }
}
