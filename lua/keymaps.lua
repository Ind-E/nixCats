-- esc exits terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

-- gcc compiles with clang
vim.keymap.set(
  "n",
  "<leader>gcc",
  [[:w<CR>:!clang % -o %:r<CR>]],
  { noremap = true }
)

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
  "n",
  "<leader>c",
  "<cmd>close<CR>",
  { silent = true, desc = "[c]lose window" }
)

vim.keymap.set("n", "<leader>n", function ()
  local number = vim.wo.number
  vim.wo.number = not number
  vim.wo.relativenumber = not number
end, { desc = "Toggle line numbers" })
