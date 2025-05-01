require('lze').load {
  {
    "mini.files.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require('mini.files').setup({})
      vim.keymap.set('n', '<leader>i', [[:lua MiniFiles.open()<CR>]], { desc = 'open files', silent = true })
    end,
  },
  {
    "mini.trailspace.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require('mini.trailspace').setup({})
      vim.api.nvim_set_keymap('n', '<leader>tw', [[:lua MiniTrailspace.trim()<CR>]], { noremap = true });
    end,
  },
  {
    "mini.surround.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require('mini.surround').setup({})
      vim.api.nvim_set_keymap('n', '<leader>s', [[:lua MiniFiles.synchronize()<CR>]], { noremap = true });
    end,
  },
  {
    "mini.ai.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require('mini.ai').setup({})
    end,
  },
}
