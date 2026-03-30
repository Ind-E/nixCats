if nixCats("full") then
  require("lze").load({
    { import = "plugins.quarto" },
    { import = "plugins.debug" },
  })
end

require("lze").load({
  { import = "plugins.completion" },
  { import = "plugins.lint" },
  { import = "plugins.format" },
  { import = "plugins.snacks" },
  { import = "plugins.treesitter" },
  { import = "plugins.mini" },
  { import = "plugins.lualine" },
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
        { noremap = true, desc = "Next Buffer", silent = true }
      )
      vim.keymap.set(
        "n",
        "gp",
        "<cmd>BufferLineCyclePrev<CR>",
        { noremap = true, desc = "Previous Buffer", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>cc",
        "<cmd>bd<CR>",
        { noremap = true, desc = "Close Buffer", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>q",
        "<cmd>bd!<CR>",
        { noremap = true, desc = "Force Close Buffer", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>co",
        "<cmd>BufferLineCloseOthers<CR>",
        { noremap = true, desc = "Close Other Buffers", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>cl",
        "<cmd>BufferLineCloseLeft<CR>",
        { noremap = true, desc = "Close Left Buffers", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>cr",
        "<cmd>BufferLineCloseRight<CR>",
        { noremap = true, desc = "Close Right Buffers", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>cp",
        "<cmd>BufferLinePickClose<CR>",
        { noremap = true, desc = "Pick Buffer to Close", silent = true }
      )
    end,
  },
  {
    "vim-slime",
    event = "DeferredUIEnter",
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

      vim.keymap.set("n", "<leader>Sp", function ()
        open_kitty_repl("python")
      end, { noremap = true, desc = "python" })
      vim.keymap.set("n", "<leader>SS", function ()
        open_kitty_repl("fish")
      end, { noremap = true, desc = "fish" })
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
          end, { desc = "Next Hunk" })

          map("n", "[g", function ()
            if vim.wo.diff then
              vim.cmd.normal({ "[g", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end, { desc = "Prev Hunk" })

          map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset Hunk" })

          map("v", "<leader>gr", function ()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end)

          map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
          map(
            "n",
            "<leader>gp",
            gitsigns.preview_hunk,
            { desc = "Float Preview Hunk Float" }
          )
          map(
            "n",
            "<leader>gi",
            gitsigns.preview_hunk_inline,
            { desc = "Inline Preview Hunk" }
          )
          map("n", "<leader>gb", function ()
            gitsigns.blame_line({ full = true })
          end, { desc = "Blame Line" })

          map(
            "n",
            "<leader>gq",
            gitsigns.setqflist,
            { desc = "Populate Quickfix Buffer" }
          )
          map("n", "<leader>gQ", function ()
            gitsigns.setqflist("all")
          end, { desc = "Populate Quickfix All" })

          map(
            "n",
            "<leader>tb",
            gitsigns.toggle_current_line_blame,
            { desc = "Toggle Current Line Blame" }
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
        { "<leader>l", group = "Lsp" },
        { "<leader>g", group = "Git" },
        { "<leader>gh", group = "GitHub" },
        { "<leader>c", group = "Close Buffers" },
        { "<leader>S", group = "Slime" },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Toggle" },
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
        { noremap = true, silent = true, desc = "Markdown preview" }
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
      vim.keymap.set("", "gw", ":HopWord<CR>", { silent = true, desc = "Hop Word" })
    end,
  },
  {
    "quick-scope",
    before = function ()
      -- vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
      vim.api.nvim_command([[
          highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
          highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
      ]])
    end,
  },
  {
    "diffview.nvim",
    enabled = nixCats("full") or false,
    event = "DeferredUIEnter",
    after = function ()
      require("diffview").setup()
    end,
  },
  {
    "typst-preview.nvim",
    enabled = nixCats("full") or false,
    ft = "typst",
    after = function ()
      require("typst-preview").setup({
        open_cmd = "firefox --new-window %s",
      })
    end,
  },
  {
    "ts-comments.nvim",
    event = "DeferredUIEnter",
    after = function ()
      require("ts-comments").setup()
    end,
  },
  {
    "chezmoi-nvim",
    lazy = false,
    after = function ()
      require("chezmoi").setup({})
      vim.keymap.set("n", "<leader>cz", function ()
        require("chezmoi.pick").snacks()
      end, { desc = "Chezmoi" })
    end,
  },
  {
    "plenary.nvim",
    dep_of = { "chezmoi-nvim", "easy-dotnet.nvim" },
  },
})
