vim.opt.cursorline = true;
vim.opt.expandtab = true;
vim.opt.mouse = "a";
vim.opt.mousescroll = "ver:1,hor:6";
vim.opt.relativenumber = true;
vim.opt.scrolloff = 12;
vim.opt.shiftwidth = 4;
vim.opt.softtabstop = 4;
vim.opt.tabstop = 4;
vim.opt.wrap = false;
vim.opt.colorcolumn = "81";

local c = require('vscode.colors').get_colors()
require('vscode').setup({
    color_overrides = {
        vscBack = '#000000',
        vscCursorDarkDark = '#171717',
        vscLeftDark = '#000000',
        vscPopupBack = '#000000',
    }
})
vim.cmd.colorscheme "vscode"
