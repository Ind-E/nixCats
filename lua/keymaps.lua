-- esc exits terminal
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true });

-- [g]cc compiles with clang
vim.keymap.set('n', '<leader>cc', [[:w<CR>:!clang % -o %:r<CR><CR>]], { noremap = true });
vim.keymap.set('n', '<leader>gcc', [[:w<CR>:!clang % -o %:r<CR>]], { noremap = true });

-- close/next/prev buffer
vim.keymap.set('n', '<leader>bd', [[:bd<CR>]], { noremap = true });
vim.keymap.set('n', '<leader>bn', [[:bn<CR>]], { noremap = true });
vim.keymap.set('n', '<leader>bp', [[:bp<CR>]], { noremap = true });
