return {
  "telescope.nvim",
  cmd = { "Telescope", },
  on_require = { "telescope", },

  after = function(plugin)
    require('telescope').setup {

    }
  end,
}
