return {
  {
    "mini.trailspace",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("mini.trailspace").setup({})
      vim.keymap.set("n", "<leader>tw", [[:lua MiniTrailspace.trim()<CR>]], { noremap = true });
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("mini.trailspace").trim()
        end,
      })
    end,
  },
  {
    "mini.surround",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("mini.surround").setup()
    end,
  },
  {
    "mini.ai",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("mini.ai").setup()
    end,
  },
  {
    "mini.align",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("mini.align").setup()
    end,
  },
  {
    "mini.pairs",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("mini.pairs").setup({
        mappings = {
          ["("] = { neigh_pattern = "[^%a'\"]." },
          ["["] = { neigh_pattern = "[^%a'\"]." },
          ['"'] = { neigh_pattern = "[^%a'\"]." },
          ["'"] = { neigh_pattern = "[^%a'\"]." },

          [")"] = { neigh_pattern = "[(]." },
          ["]"] = { neigh_pattern = "[[]." },
          ["}"] = { neigh_pattern = "[{]." },
          ["`"] = false,
        }
      })
    end,
  }
}
