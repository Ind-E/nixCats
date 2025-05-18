-- non lazy-loaded plugins
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

require("mini.files").setup({})
vim.keymap.set(
  "n",
  "<leader>i",
  [[:lua MiniFiles.open()<CR>]],
  { desc = "open files", silent = true }
)
-- vim.keymap.set("n", "<leader>s", [[:lua MiniFiles.synchronize()<CR>]], { noremap = true }); <- use =

require("bufferline").setup({})
vim.keymap.set(
  "n",
  "<leader>bcl",
  ":BufferLineCloseLeft<CR>",
  { desc = "[l]eft", silent = true }
)
vim.keymap.set(
  "n",
  "<leader>bcr",
  ":BufferLineCloseRight<CR>",
  { desc = "[r]ight", silent = true }
)
vim.keymap.set(
  "n",
  "<leader>bco",
  ":BufferLineCloseOthers<CR>",
  { desc = "[o]thers", silent = true }
)
vim.keymap.set(
  "n",
  "<leader>bmn",
  ":BufferLineMoveNext<CR>",
  { desc = "[n]ext", silent = true }
)
vim.keymap.set(
  "n",
  "<leader>bmp",
  ":BufferLineMovePrev<CR>",
  { desc = "[p]revious", silent = true }
)
vim.keymap.set(
  "n",
  "<leader>bn",
  ":BufferLineCycleNext<CR>",
  { noremap = true, desc = "[n]ext", silent = true }
)
vim.keymap.set(
  "n",
  "<leader>bp",
  ":BufferLineCyclePrev<CR>",
  { noremap = true, desc = "[p]revious", silent = true }
)
vim.keymap.set(
  "n",
  "<leader>bd",
  ":bd<CR>",
  { noremap = true, desc = "[d]elete", silent = true }
)
vim.keymap.set(
  "n",
  "<leader>bs",
  ":BufferLinePick<CR>",
  { noremap = true, desc = "[s]elect", silent = true }
)
vim.keymap.set(
  "n",
  "<leader>bP",
  ":BufferLineTogglePin<CR>",
  { noremap = true, desc = "[P]in", silent = true }
)

-- lazy loading starts here
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
    "comment.nvim",
    event = "DeferredUIEnter",
    after = function (plugin)
      require("Comment").setup()
    end,
  },
  {
    "lualine.nvim",
    event = "DeferredUIEnter",
    after = function (plugin)
      require("lualine").setup({
        options = {
          component_separators = { left = "", right = "" },
          section_separator = { left = "", right = "" },
          globalStatus = true,
          ignore_focus = { "minifiles" },
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
    after = function (plugin)
      require("gitsigns").setup({})
    end,
  },
  {
    "which-key.nvim",
    event = "DeferredUIEnter",
    after = function (plugin)
      require("which-key").setup({})
      require("which-key").add({
        { "<leader>b", group = "[b]uffers" },
        { "<leader>bc", group = "[c]lose" },
        { "<leader>bm", group = "[m]ove" },
        { "<leader>l", group = "[l]sp" },
        { "<leader>f", group = "[f]ind" },
        { "<leader>m", group = "[m]olten" },
        { "<leader>r", group = "[r]un" },
        { "<leader>y", icon = { icon = "", color = "cyan" } },
      })
    end,
  },
  {
    "auto-save.nvim",
    event = "DeferredUIEnter",
    after = function (plugin)
      require("auto-save").setup({})
    end,
  },
  {
    "nvim-colorizer",
    event = "BufReadPre",
    after = function (plugin)
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
    after = function (plugin)
      vim.cmd([[
        function! OpenMarkdownPreview(url)
        silent execute "!firefox --new-window " . a:url
        endfunction
      ]])

      vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
      vim.keymap.set(
        "n",
        "<leader>tm",
        ":MarkdownPreviewToggle<CR>",
        { noremap = true, silent = true, desc = "[t]oggle [m]arkdown preview" }
      )
    end,
  },
  {
    "vim-sleuth",
    event = { "BufReadPost", "BufNewFile" },
    after = function (plugin)
      vim.cmd("packadd vim-sleuth")
    end,
  },
})
