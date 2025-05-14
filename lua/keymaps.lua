-- esc exits terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true });

-- [g]cc compiles with clang
vim.keymap.set("n", "<leader>cc", [[:w<CR>:!clang % -o %:r<CR><CR>]], { noremap = true });
vim.keymap.set("n", "<leader>gcc", [[:w<CR>:!clang % -o %:r<CR>]], { noremap = true });

-- close/next/prev/alternate buffer
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { noremap = true });
vim.keymap.set("n", "<leader>bn", ":bn<CR>", { noremap = true });
vim.keymap.set("n", "<leader>bp", ":bp<CR>", { noremap = true });
vim.keymap.set("n", "<leader>bb", "b#<CR>", { noremap = true });

-- escape turns off latest search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Moves Line Down' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Moves Line Up' })

-- system clipboard
vim.keymap.set({ "v", "x", "n" }, '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Yank to clipboard' })
vim.keymap.set({ "n", "v", "x" }, '<leader>Y', '"+yy', { noremap = true, silent = true, desc = 'Yank line to clipboard' })
vim.keymap.set({ "n", "v", "x" }, '<C-a>', 'gg0vG$', { noremap = true, silent = true, desc = 'Select all' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p', { noremap = true, silent = true, desc = 'Paste from clipboard' })
vim.keymap.set('i', '<C-p>', '<C-r><C-p>+',
    { noremap = true, silent = true, desc = 'Paste from clipboard from within insert mode' })

vim.keymap.set('n', '<leader>lp', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', '<leader>ln', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>lh', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>ll', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
