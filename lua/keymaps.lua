-- esc exits terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

-- escape turns off latest search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- K/J to move lines up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves Line Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves Line Up" })

-- <leader>y/p for system clipboard
vim.keymap.set(
  { "v", "x", "n" },
  "<leader>y",
  '"+y',
  { noremap = true, silent = true, desc = "[y]ank to system clipboard" }
)
vim.keymap.set(
  { "n", "v", "x" },
  "<leader>p",
  '"+p',
  { noremap = true, silent = true, desc = "[p]aste from system clipboard" }
)
vim.keymap.set(
  { "n", "v", "x" },
  "<leader>P",
  '"+P',
  { noremap = true, silent = true, desc = "[P]aste from system clipboard" }
)

-- <leader>C close current window
vim.keymap.set(
  "n",
  "<leader>C",
  "<cmd>close<CR>",
  { silent = true, desc = "[q]lose window" }
)

-- helix inspired maps

-- gh start of line
vim.keymap.set("", "gh", "0", { silent = true, desc = "goto line start" })
-- gs first non-whitespace character in line
vim.keymap.set(
  "",
  "gs",
  "^",
  { silent = true, desc = "goto first non-blank in line" }
)
-- gl end of line
vim.keymap.set("", "gl", "$", { silent = true, desc = "goto line end" })
-- <C-c> toggle comment
vim.keymap.set(
  "n",
  "<C-c>",
  "gcc",
  { remap = true, silent = true, desc = "comment" }
)
vim.keymap.set("v", "<C-c>", "gc", { remap = true, silent = true, desc = "comment" })

-- <A-u>/<A-U> earler/later
vim.keymap.set("n", "<A-u>", "<cmd>earlier<CR>", { silent = true, desc = "earlier" })
vim.keymap.set("n", "<A-U>", "<cmd>later<CR>", { silent = true, desc = "later" })

-- U redo
vim.keymap.set("n", "U", "<C-r>", { silent = true, desc = "redo" })

-- ge end of file
vim.keymap.set("", "ge", "G", { silent = true, desc = "end of file" })

-- g[t|c|b] [top|center|bottom] of screen
vim.keymap.set("", "gt", "H", { silent = true, desc = "goto top of screen" })
vim.keymap.set("n", "gc", "M", { silent = true, desc = "goto center of screen" })
vim.keymap.set("", "gb", "L", { silent = true, desc = "goto bottom of screen" })

-- gd goto definition
vim.keymap.set("n", "gd", "<C-]>", { silent = true, desc = "goto definition" })

-- ga alternate file
vim.keymap.set(
  "",
  "ga",
  ":e #<CR>",
  { remap = true, silent = true, desc = "alternate file" }
)

vim.keymap.del("n", "grt")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gra")
vim.keymap.del("x", "gra")
vim.keymap.del("n", "grn")

local function yazi ()
  local tmp_file = os.tmpname()
  local current_file = vim.api.nvim_buf_get_name(0)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buf)

  vim.fn.jobstart({ "yazi", current_file, "--chooser-file=" .. tmp_file }, {
    term = true,
    on_exit = function ()
      local f = io.open(tmp_file, "r")
      local paths = {}
      if f then
        for line in f:lines() do
          table.insert(paths, line)
        end
        f:close()
        os.remove(tmp_file)
      end

      if vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
      end

      if #paths > 0 then
        for i, path in ipairs(paths) do
          if i == 1 then
            vim.cmd("edit " .. vim.fn.fnameescape(path))
          else
            vim.cmd("badd " .. vim.fn.fnameescape(path))
          end
        end
      end
    end,
  })

  local opts = { buffer = buf, nowait = true }
  vim.keymap.set("t", "<Esc>", "<Esc>", opts)
  vim.keymap.set("t", "<C-w>", "<C-w>", opts)
  vim.keymap.set("t", "<C-v>", "<C-v>", opts)

  vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>i", yazi, { desc = "yazi" })
