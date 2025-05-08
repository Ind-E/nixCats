require('lze').load {
  {
    "nvim-lspconfig",
    on_require = { "lspconfig" },
    lsp = function(plugin)
      vim.lsp.config(plugin.name, plugin.lsp or {})
      vim.lsp.config(plugin.name)
    end,
    before = function(_)
      vim.lsp.config('*', {
        on_attach = require('LSPs.on_attach'),
      })
    end,
  },
  {
    "lazydev.nvim",
    cmd = { "LazyDev" },
    ft = "lua",
    after = function(_)
      require('lazydev').setup({
        library = {
          { words = { "nixCats" }, path = (nixCats.nixCatsPath or "") .. '/lua' },
        },
      })
    end,
  },
  {
    "lua_ls",
    lsp = {
      filetypes = { 'lua' },
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          formatters = {
            ignoreComments = true,
          },
          signatureHelp = { enabled = true },
          diagnositcs = {
            globals = { "nixCats", "vim", },
            disable = { "missing-fields", },
          },
          telemetry = { enabled = false },
        },
      },
    },
  },
}
