return {
  {
    "mini.files.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require('mini.files').setup()
      vim.keymap.set('n', '<leader>i', [[:lua MiniFiles.open()<CR>]], { desc = 'open files', silent = true })
    end,
  },
  {
    "mini.trailspace",
    event = "DeferredUIEnter",
    after = function(plugin)
      require('mini.trailspace').setup({})
      vim.api.nvim_set_keymap('n', '<leader>tw', [[:lua MiniTrailspace.trim()<CR>]], { noremap = true });
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require('mini.trailspace').trim()
        end,
      })
    end,
  },
  {
    "mini.surround",
    event = "DeferredUIEnter",
    after = function(plugin)
      require('mini.surround').setup()
      vim.api.nvim_set_keymap('n', '<leader>s', [[:lua MiniFiles.synchronize()<CR>]], { noremap = true });
    end,
  },
  {
    "mini.ai",
    event = "DeferredUIEnter",
    after = function(plugin)
      require('mini.ai').setup()
    end,
  },
  {
    "mini.align",
    event = "DeferredUIEnter",
    after = function(plugin)
      require('mini.align').setup()
    end,
  },
  {
    "mini.pairs",
    event = "DeferredUIEnter",
    after = function(plugin)
      require('mini.pairs').setup({
        mappings = {
          ['('] = { neigh_pattern = '[^%a\'"].' },
          ['['] = { neigh_pattern = '[^%a\'"].' },
          ['"'] = { neigh_pattern = '[^%a\'"].' },
          ["'"] = { neigh_pattern = '[^%a\'"].' },

          [')'] = { neigh_pattern = '[(].' },
          [']'] = { neigh_pattern = '[[].' },
          ['}'] = { neigh_pattern = '[{].' },
          ['`'] = false,
        }
      })
    end,
  }
}
