vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.expandtab = true;
vim.opt.shiftwidth = 4;
vim.opt.softtabstop = 4;
vim.opt.tabstop = 4;
vim.opt.smartindent = true;

vim.opt.colorcolumn = "82";
vim.opt.wrap = false;

vim.opt.relativenumber = true;
vim.opt.number = true;
vim.opt.numberwidth = 4;
vim.opt.signcolumn = "yes";
vim.opt.scrolloff = 12;
vim.opt.cursorline = true;

vim.opt.hlsearch = true;
vim.opt.ignorecase = true;
vim.opt.incsearch = true;
vim.opt.smartcase = true;

vim.opt.mouse = "a";
vim.opt.mousescroll = "ver:1,hor:6";

vim.opt.swapfile = false;
vim.opt.backup = false;
vim.opt.undofile = true;

vim.opt.termguicolors = true;

vim.opt.shell = "zsh";

vim.opt.list = true;
vim.opt.listchars = { nbsp = "␣" };

vim.opt.inccommand = "split";
vim.opt.completeopt = "menu,preview,noselect";

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.opt.formatoptions:remove({ "o", })
    end,
})

vim.diagnostic.config({
    virtual_text = true,
    signs = false,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
