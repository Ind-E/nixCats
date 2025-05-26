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
        "<leader>bD",
        "<cmd>bd!<CR>",
        { noremap = true, desc = "[D]elete!", silent = true }
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
    {
    "quick-scope",
    before = function ()
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
      vim.cmd([[
  augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg='#dcdcaa' gui=underline
    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#c586c0' gui=underline
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
    "wiki.vim",
    before = function ()
      vim.g.wiki_root = "~/wiki"
    end,
  },
  {
    "vim-fugitive",
    event = "DeferredUIEnter",
  },
  {
    "vim-slime",
    before = function ()
      vim.g.slime_target = "kitty"
      -- vim.g.slime_target = "zellij"
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
    "vim-plugin-AnsiEsc",
  }
})
