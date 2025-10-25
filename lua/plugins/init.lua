require("lze").load({
  -- { import = "plugins.debug", },
  { import = "plugins.quarto" },
  { import = "plugins.completion" },
  { import = "plugins.lint" },
  { import = "plugins.format" },
  { import = "plugins.telescope" },
  { import = "plugins.treesitter" },
  { import = "plugins.mini" },
  { import = "plugins.lualine" },
  { import = "plugins.markview" },
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
      require("bufferline").setup({
        options = {
          middle_mouse_command = "bdelete! %d",
          right_mouse_command = false,
          max_name_length = 15,
          tab_size = 15,
        },
      })
      vim.keymap.set(
        "n",
        "gn",
        "<cmd>BufferLineCycleNext<CR>",
        { noremap = true, desc = "[n]ext", silent = true }
      )
      vim.keymap.set(
        "n",
        "gp",
        "<cmd>BufferLineCyclePrev<CR>",
        { noremap = true, desc = "[p]revious", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>c",
        "<cmd>bd<CR>",
        { noremap = true, desc = "[d]elete", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>C",
        "<cmd>bd!<CR>",
        { noremap = true, desc = "[D]elete!", silent = true }
      )
    end,
  },
  {
    "gitsigns.nvim",
    event = "DeferredUIEnter",
    after = function ()
      require("gitsigns").setup({
        on_attach = function (bufnr)
          local gitsigns = require("gitsigns")
          local function map (mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map("n", "]g", function ()
            if vim.wo.diff then
              vim.cmd.normal({ "]g", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end)

          map("n", "[g", function ()
            if vim.wo.diff then
              vim.cmd.normal({ "[g", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end)

          map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "[s]tage hunk" })
          map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "[r]eset hunk" })

          map("v", "<leader>gs", function ()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end)

          map("v", "<leader>gr", function ()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end)

          map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "[S]tage buffer" })
          map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "[R]eset buffer" })
          map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "[p]review hunk" })
          map(
            "n",
            "<leader>gi",
            gitsigns.preview_hunk_inline,
            { desc = "[i]nline preview hunk" }
          )
          map("n", "<leader>gb", function ()
            gitsigns.blame_line({ full = true })
          end, { desc = "[b]lame line" })

          map("n", "<leader>gd", gitsigns.diffthis, { desc = "[d]iff current file" })

          map("n", "<leader>gD", function ()
            gitsigns.diffthis("~")
          end, { desc = "[D]iff" })

          map("n", "<leader>gq", gitsigns.setqflist, { desc = "[q]uickfix current" })
          map("n", "<leader>gQ", function ()
            gitsigns.setqflist("all")
          end, { desc = "populate [Q]uickfix all" })

          map(
            "n",
            "<leader>tb",
            gitsigns.toggle_current_line_blame,
            { desc = "[t]oggle current line [b]lame" }
          )

          map({ "o", "x" }, "ih", gitsigns.select_hunk)
        end,
      })
    end,
  },
  {
    "which-key.nvim",
    event = "DeferredUIEnter",
    dep_of = "crates.nvim",
    after = function ()
      require("which-key").setup({
        icons = {
          mappings = false,
        },
      })
      require("which-key").add({
        { "<leader>l", group = "[l]sp" },
        { "<leader>f", group = "[f]ind" },
        { "<leader>m", group = "[m]olten" },
        { "<leader>r", group = "[r]un" },
        { "<leader>w", group = "[w]iki" },
        { "<leader>wg", group = "[g]raph" },
        { "<leader>ws", group = "tag[s]" },
        { "<leader>wl", group = "[l]inks" },
        { "<leader>w<leader>", group = "journal" },
        { "<leader>fg", group = "[g]it" },
        { "<leader>g", group = "[g]it" },
        { "<leader>s", group = "[s]lime" },
        { "<leader>t", group = "[t]oggle" },
        { "<leader>l", group = "lsp" },
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
          names = false,
          mode = "virtualtext",
          virtualtext = "󰝤",
          virtualtext_inline = true,
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
    "hop.nvim",
    event = "DeferredUIEnter",
    after = function ()
      require("hop").setup()
      vim.keymap.set(
        "n",
        "gw",
        ":HopWord<CR>",
        { silent = true, desc = "[g]oto [w]ord" }
      )
    end,
  },
  {
    "quick-scope",
    before = function ()
      -- vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
      vim.cmd([[
  augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg='#ffd602' gui=underline
    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#f28b25' gui=underline
  augroup END
      ]])
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
    "vim-fugitive",
    event = "DeferredUIEnter",
    after = function ()
      vim.keymap.set("n", "<leader>G", ":G ", { desc = "[G]it" })
    end,
  },

  {
    "hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    after = function ()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          style = {
            { fg = "#569cd6" },
            { fg = "#f44747" },
          },
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "┌",
            left_bottom = "└",
            right_arrow = "─",
          },
          duration = 0,
          delay = 20,
        },
      })
    end,
  },
  {
    "typst-preview.nvim",
    ft = "typst",
    after = function ()
      require("typst-preview").setup({
        open_cmd = "firefox --new-window %s",
      })
    end,
  },
})
