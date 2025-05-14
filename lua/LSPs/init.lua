require("lze").load {
  {
    "nvim-lspconfig",
    on_require = { "lspconfig" },
    lsp = function(plugin)
      vim.lsp.config(plugin.name, plugin.lsp or {})
      vim.lsp.enable(plugin.name)
    end,
    before = function(_)
      vim.lsp.config("*", {
        on_attach = require("LSPs.on_attach"),
      })
    end,
  },
  {
    "lazydev.nvim",
    cmd = { "LazyDev" },
    ft = "lua",
    after = function(_)
      require("lazydev").setup({
        library = {
          { words = { "nixCats" }, path = (nixCats.nixCatsPath or "") .. "/lua" },
        },
      })
    end,
  },
  {
    "lua_ls",
    lsp = {
      filetypes = { "lua" },
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
  {
    "nixd",
    lsp = {
      filetypes = { "nix" },
      settings = {
        nixd = {
          formatting = {
            command = { "nixfmt" }
          },
        },
      },
    },
  },
  {
    "clangd",
    lsp = {},
  },
  {
    "basedpyright",
    lsp = {},
  },
  {
    "rust_analyzer",
    lsp = {},
  },
  {
    "marksman",
    lsp = {},
  },
  {
    "ts_ls",
    lsp = {},
  },
  {
    "bashls",
    lsp = {},
  },
  {
    "cssls",
    lsp = {},
  },
  {
    "jdtls",
    lsp = {},
  },
  -- {
  --   "nvim-jdtls",
  --   event = "FileType",
  --   filetypes = { "java" },
  --   after = function(plugin)
  --     local config = {
  --       cmd = { "jdtls" },
  --       root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  --     }
  --     require("jdtls").start_or_attach(config)
  --   end,
  -- },
}
