require('plugins.completion');
require('plugins.lint');
require('plugins.debug');
require('plugins.format');
require('plugins.telescope');
require('plugins.treesitter');
require('plugins.mini');


require('lze').load {
  {
    "comment.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require('Comment').setup()
    end,
  },
  {
    "lualine.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require('lualine').setup({})
    end,
  },
  {
    "gitsigns.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require('gitsigns').setup({})
    end,
  },
  {
    "which-key.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require('which-key').setup({})
      require('which-key').add {
        { "<leader>b", group = "[b]uffers" },
        { "<leader>g", group = "[g]it" },
      }
    end,
  },
  {
    "auto-save.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require('auto-save').setup({});
    end,
  },
  {
    "bufferline.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require('bufferline').setup({});
    end,
  },
}
