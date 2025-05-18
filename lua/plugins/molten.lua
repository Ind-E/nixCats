return {
  {
    "image.nvim",
    after = function ()
      require("image").setup({
        backend = "kitty",
        kitty_method = "normal",
        integrations = {
          markdown = {
            filetypes = { "markdown", "quarto" },
          },
        },
        max_width = 200,
        max_height = 24,
        max_height_window_percentage = math.huge,
        max_width_window_percentage = math.huge,
        window_overlap_clear_enabled = true,
      })
    end,
  },
  {
    "molten-nvim",
    before = function ()
      vim.g.molten_image_provider = "image.nvim"
    end,
    after = function ()
      vim.cmd.packadd("molten-nvim")
    end,
  },
}
