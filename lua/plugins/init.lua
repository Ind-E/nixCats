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
    dep_of = "crates.nvim",
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
    end,
    after = function ()
      local function open_kitty_repl (repl)
        local tmp_win = "/tmp/kitty_repl_id"
        local tmp_listen = "/tmp/kitty_listen_on"

        os.remove(tmp_win)
        os.remove(tmp_listen)
        local kitty_cmd = string.format(
          [[
kitty --detach -o allow_remote_control=yes -e bash -c '
  while [ -z "$KITTY_WINDOW_ID" ] || [ -z $KITTY_LISTEN_ON ]; do sleep 0.05; done
  echo $KITTY_WINDOW_ID > /tmp/kitty_repl_id
  echo $KITTY_LISTEN_ON > /tmp/kitty_listen_on
  direnv exec . %s
'
]],
          repl
        )
        os.execute(kitty_cmd)

        vim.wait(500, function ()
          local f1 = io.open(tmp_win, "r")
          local f2 = io.open(tmp_listen, "r")
          if f1 and f2 then
            f1:close()
            f2:close()
            return true
          end
          return false
        end, 50)

        local winid, listen_on

        local f1 = io.open(tmp_win, "r")
        if f1 then
          winid = f1:read("*l")
          f1:close()
        end

        local f2 = io.open(tmp_listen, "r")
        if f2 then
          listen_on = f2:read("*l")
          f2:close()
        end

        if not (winid and listen_on) then
          print("Failed to read kitty repl window ID")
          return
        end

        vim.g.slime_default_config = { window_id = winid, listen_on = listen_on }
        vim.g.slime_dont_ask_default = 1
      end

      vim.keymap.set("n", "<leader>sp", function ()
        open_kitty_repl("python")
      end, { noremap = true, desc = "python repl" })
      vim.keymap.set("n", "<leader>sz", function ()
        open_kitty_repl("zsh")
      end, { noremap = true })
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
})
