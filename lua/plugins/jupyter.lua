return {
  {
    "molten-nvim",
    ft = { "quarto" },
    after = function ()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_auto_open_output = false
      vim.keymap.set(
        "n",
        "<localleader>mi",
        ":MoltenInit<CR>",
        { desc = "[i]nit", silent = true }
      )
      vim.keymap.set(
        "n",
        "<localleader>me",
        ":MoltenEvaluateOperator<CR>",
        { desc = "[e]valuate operator", silent = true }
      )
      vim.keymap.set(
        "n",
        "<localleader>mo",
        ":noautocmd MoltenEnterOutput<CR>",
        { desc = "[o]pen output window", silent = true }
      )
      vim.keymap.set(
        "n",
        "<localleader>mr",
        ":MoltenReevaluateCell<CR>",
        { desc = "[r]e-eval cell", silent = true }
      )
      vim.keymap.set(
        "v",
        "<localleader>me",
        ":<C-u>MoltenEvaluateVisual<CR>gv",
        { desc = "[e]xecute visual selection", silent = true }
      )
      vim.keymap.set(
        "n",
        "<localleader>mc",
        ":MoltenHideOutput<CR>",
        { desc = "[c]lose output window", silent = true }
      )
      vim.keymap.set(
        "n",
        "<localleader>md",
        ":MoltenDelete<CR>",
        { desc = "[d]elete Molten cell", silent = true }
      )
    end,
  },
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
}
