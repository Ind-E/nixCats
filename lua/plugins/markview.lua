return {
  "markview.nvim",
  ft = { "markdown", "quarto" },
  after = function ()
    require("markview").setup({
      markdown = {
        headings = {
          enable = true,

          shift_width = 1,
          org_indent = false,
          org_indent_wrap = true,

          heading_1 = {
            style = "icon",
            sign = "󰌕 ",
            sign_hl = "MarkviewHeading1Sign",

            icon = "  ",
            hl = "MarkviewHeading1",
          },
          heading_2 = {
            style = "icon",
            sign = "󰌖 ",
            sign_hl = "MarkviewHeading2Sign",

            icon = "  ",
            hl = "MarkviewHeading2",
          },
          heading_3 = {
            style = "icon",
            icon = "󰜁  ",
            hl = "MarkviewHeading3",
          },
          heading_4 = {
            style = "icon",
            icon = "󰜀  ",
            hl = "MarkviewHeading4",
          },
          heading_5 = {
            style = "icon",
            icon = "󰋘  ",
            hl = "MarkviewHeading5",
          },
          heading_6 = {
            style = "icon",
            icon = "󰋙  ",
            hl = "MarkviewHeading6",
          },

          setext_1 = {
            style = "decorated",

            sign = "󰌕 ",
            sign_hl = "MarkviewHeading1Sign",
            icon = "  ",
            hl = "MarkviewHeading1",
            border = "▂",
          },
          setext_2 = {
            style = "decorated",

            sign = "󰌖 ",
            sign_hl = "MarkviewHeading2Sign",
            icon = "  ",
            hl = "MarkviewHeading2",
            border = "▁",
          },
        },
      },
      preview = {
        enable = false,
        icon_provider = "devicons",
        debounce = 50,
      },
      markdown_inline = {
        checkboxes = {
          checked = {
            text = "",
            hl = "MarkviewCheckboxCancelled",
            scope_hl = "MarkviewCheckboxStriked",
          },
          unchecked = {
            text = "",
          },
        },
      },
    })
    require("markview.extras.checkboxes").setup()
    vim.keymap.set("n", "<leader>mt", ":Markview Toggle<CR>", { silent = true })
    vim.keymap.set("n", "<C-l>", ":Checkbox toggle<CR>", { silent = true })
    vim.keymap.set("n", "<C-h>", "o- [ ] ", { silent = true })
  end,
}
