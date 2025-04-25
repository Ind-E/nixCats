require('config.keymaps');
require('config.options');

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


require('config.LSPs');
require('config.plugins');
