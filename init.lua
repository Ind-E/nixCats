require("options")
require("keymaps")

if nixCats("cliphist") then
  require("cliphist")
elseif nixCats("kitty") then
  require("kitty")
else
  require("lze").register_handlers(require("lzextras").lsp)
  require("plugins")
  require("LSPs")
end

require("lze").load({
  {
    "vscode.nvim",
    after = function ()
      require("vscode.colors").get_colors()
      require("vscode").setup({
        transparent = true,
        color_overrides = {
          vscBack = "#000000",
          vscCursorDarkDark = "#171717",
          vscLeftDark = "#000000",
          vscPopupBack = "#000000",
          vscTabOutside = "#000000",
        },
      })
      vim.cmd.colorscheme("vscode")
    end,
  },
})
