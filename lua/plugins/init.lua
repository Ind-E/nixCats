require("lze").load({
  -- { import = "plugins.debug", },
  { import = "plugins.quarto" },
  { import = "plugins.completion" },
  { import = "plugins.lint" },
  { import = "plugins.format" },
  { import = "plugins.telescope" },
  { import = "plugins.treesitter" },
  { import = "plugins.mini" },
  {
    "vscode.nvim",
    after = function ()
      require("vscode.colors").get_colors()
      require("vscode").setup({
        color_overrides = {
          vscBack = "#000000",
          vscCursorDarkDark = "#171717",
          vscLeftDark = "#000000",
          vscPopupBack = "#000000",
        },
      })
      vim.cmd.colorscheme("vscode")
    end,
  },
  {
    "bufferline.nvim",
    after = function ()
      require("bufferline").setup({})
      vim.keymap.set(
        "n",
        "<leader>bcl",
        "<cmd>BufferLineCloseLeft<CR>",
        { desc = "[l]eft", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>bcr",
        "<cmd>BufferLineCloseRight<CR>",
        { desc = "[r]ight", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>bco",
        "<cmd>BufferLineCloseOthers<CR>",
        { desc = "[o]thers", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>bmn",
        "<cmd>BufferLineMoveNext<CR>",
        { desc = "[n]ext", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>bmp",
        "<cmd>BufferLineMovePrev<CR>",
        { desc = "[p]revious", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>bn",
        "<cmd>BufferLineCycleNext<CR>",
        { noremap = true, desc = "[n]ext", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>bp",
        "<cmd>BufferLineCyclePrev<CR>",
        { noremap = true, desc = "[p]revious", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>bd",
        "<cmd>bd<CR>",
        { noremap = true, desc = "[d]elete", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>bs",
        "<cmd>BufferLinePick<CR>",
        { noremap = true, desc = "[s]elect", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>bP",
        "<cmd>BufferLineTogglePin<CR>",
        { noremap = true, desc = "[P]in", silent = true }
      )
    end,
  },
  {
    "comment.nvim",
    event = "DeferredUIEnter",
    after = function ()
      require("Comment").setup()
    end,
  },
  {
    "lualine.nvim",
    event = "DeferredUIEnter",
    after = function ()
      require("lualine").setup({
        options = {
          component_separators = { left = "", right = "" },
          section_separator = { left = "", right = "" },
          globalStatus = true,
          ignore_focus = { "yazi" },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              icons_enabled = true,
              separator = {
                left = "",
                right = "",
              },
            },
            {
              "",
              draw_empty = true,
              separator = { left = "", right = "" },
            },
          },
          lualine_b = {
            {
              "filetype",
              colored = true,
              icon_only = true,
              icon = { align = "left" },
            },
            {
              "filename",
              symbols = { modified = " ", readonly = " " },
              separator = { right = "" },
            },
            {
              "",
              draw_empty = true,
              separator = { left = "", right = "" },
            },
          },
          lualine_c = {
            {
              "diff",
              colored = false,
              diff_color = {
                added = "DifAdd",
                modified = "DiffChange",
                removed = "DiffDelete",
              },
              symbols = { added = "+", modified = "~", removed = "-" },
              separator = { right = "" },
            },
          },
          lualine_x = {
            {
              function ()
                local bufnr = vim.api.nvim_get_current_buf()
                local clients = vim.lsp.get_clients({ bufnr = bufnr })

                if vim.tbl_isempty(clients) then
                  return "No Active LSP"
                end

                local active_clients = {}
                for _, client in ipairs(clients) do
                  table.insert(active_clients, client.name)
                end

                return table.concat(active_clients, ", ")
              end,
              icon = " ",
              separator = { left = "" },
            },
            {
              "diagnostics",
              sources = { "nvim_lsp", "nvim_diagnostic", "vim_lsp", "coc" },
              symbols = { error = "󰅙 ", warn = " ", hint = "󰌵" },
              colored = true,
              update_in_insert = false,
              always_visible = false,
              diagnostics_color = {
                color_error = { fg = "red" },
                color_warn = { fg = "yellow" },
                color_nfo = { fg = "cyan" },
              },
            },
          },
          lualine_y = {
            {
              "",
              draw_empty = true,
              separator = { left = "", right = "" },
            },
            {
              "searchcount",
              maxcount = 999,
              timeout = 120,
              separator = { left = "" },
            },
            {
              "branch",
              icon = "",
              separator = { left = "" },
            },
          },
          lualine_z = {
            {
              "",
              draw_empty = true,
              separator = { left = "", right = "" },
            },
            {
              "progress",
              separator = { left = "" },
            },
            {
              "location",
            },
            {
              "fileformat",
              color = { fg = "black" },
              symbols = {
                unix = "",
                dos = "",
                mac = "",
              },
            },
          },
        },
        inactive_sections = {
          lualine_c = {
            {
              "filename",
            },
          },
          lualine_x = {
            {
              "location",
            },
          },
        },
      })
    end,
  },
  {
    "gitsigns.nvim",
    event = "DeferredUIEnter",
    after = function ()
      require("gitsigns").setup({})
    end,
  },
  {
    "which-key.nvim",
    event = "DeferredUIEnter",
    after = function ()
      require("which-key").setup()
      require("which-key").add({
        { "<leader>b", group = "[b]uffers" },
        { "<leader>bc", group = "[c]lose" },
        { "<leader>bm", group = "[m]ove" },
        { "<leader>l", group = "[l]sp" },
        { "<leader>f", group = "[f]ind" },
        { "<leader>m", group = "[m]olten" },
        { "<leader>r", group = "[r]un" },
        { "<leader>w", group = "[w]iki" },
        { "<leader>wg", group = "[g]raph" },
        { "<leader>ws", group = "tag[s]" },
        { "<leader>wl", group = "[l]inks" },
        { "<leader>w<leader>", group = "journal" },
        -- { "<leader>y", icon = { icon = "", color = "cyan" } },
      })
    end,
  },
  {
    "auto-save.nvim",
    event = "DeferredUIEnter",
    after = function ()
      require("auto-save").setup({})
    end,
  },
  {
    "nvim-colorizer",
    event = "BufReadPre",
    after = function ()
      require("colorizer").setup({
        user_default_options = {
          mode = "virtualtext",
          virtualtext = "󰝤",
        },
      })
    end,
  },
  {
    "markdown-preview.nvim",
    event = "DeferredUIEnter",
    ft = { "markdown" },
    build = function ()
      vim.fn["mkdp#util#install"]()
    end,
    after = function ()
      vim.cmd([[
        function! OpenMarkdownPreview(url)
        silent execute "!firefox --new-window " . a:url
        endfunction
      ]])

      vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
      vim.keymap.set(
        "n",
        "<leader>tm",
        "<cmd>MarkdownPreviewToggle<CR>",
        { noremap = true, silent = true, desc = "[t]oggle [m]arkdown preview" }
      )
    end,
  },
  {
    "vim-sleuth",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "yazi.nvim",
    event = "DeferredUIEnter",
    keys = {
      {
        "<leader>i",
        mode = { "n" },
        "<cmd>Yazi<CR>",
        desc = "Yaz[i]",
      },
    },
    after = function ()
      require("yazi").setup({
        open_for_directories = true,
        floating_window_scaling_factor = 0.8,
      })
    end,
  },
  -- {
  --   "hardtime.nvim",
  --   after = function ()
  --     require("hardtime").setup({
  --       max_count = 10,
  --     })
  --   end,
  -- },
  -- {
  --   "nui.nvim",
  --   dep_of = { "hardtime.nvim" },
  -- },
  {
    "quick-scope",
    before = function ()
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }

      vim.api.nvim_set_hl(0, "QuickScopePrimary", {
        fg = "#afff5f",
        underline = true,
      })

      vim.api.nvim_set_hl(0, "QuickScopeSecondary", {
        fg = "#5fffff",
        underline = true,
      })
    end,
    after = function ()
      vim.cmd("packadd quick-scope")
    end,
  },
  {
    "diffview.nvim",
    event = "DeferredUIEnter",
    after = function ()
      require("diffview").setup()
    end,
  },
  {
    "wiki.vim",
    event = "BufReadPre",
    before = function ()
      vim.g.wiki_root = "~/wiki"
    end,
  },
  {
    "markview.nvim",
    ft = { "markdown" },
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
      require("markview.extras.checkboxes").setup({})
      vim.keymap.set("n", "<leader>m", ":Markview Toggle<CR>", { silent = true })
      vim.keymap.set("n", "<C-l>", ":Checkbox toggle<CR>", { silent = true })
      vim.keymap.set("n", "<C-h>", "o- [ ] ", { silent = true })
    end,
  },
})
