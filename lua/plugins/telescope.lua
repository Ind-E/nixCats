return {
  "telescope.nvim",
  cmd = { "Telescope" },
  on_require = { "telescope" },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "[f]ile" },
  },
  after = function ()
    require("telescope").setup({})
  end,
}
