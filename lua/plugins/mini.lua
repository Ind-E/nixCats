require('lze').load {
  {
    "mini.files.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require('mini.files').setup({})
      vim.keymap.set('n', '<leader>i', [[:lua MiniFiles.open()<CR>]], { desc = 'open files', silent = true})
    end,
  },
}

require('mini.trailspace').setup({});
require('mini.surround').setup({});
require('mini.ai').setup({});

-- <leader> s to synchronize files
vim.api.nvim_set_keymap('n', '<leader>s', [[:lua MiniFiles.synchronize()<CR>]], { noremap = true });

-- <leader> tw to trim whitespace
vim.api.nvim_set_keymap('n', '<leader>tw', [[:lua MiniTrailspace.trim()<CR>]], { noremap = true });

