require("lze").load({
  {
    "nvim-lspconfig",
    on_require = { "lspconfig" },
    lsp = function (plugin)
      vim.lsp.config(plugin.name, plugin.lsp or {})
      vim.lsp.enable(plugin.name)
    end,
    before = function (_)
      vim.lsp.config("*", {
        on_attach = require("LSPs.on_attach"),
      })
    end,
  },
  {
    "lazydev.nvim",
    cmd = { "LazyDev" },
    ft = "lua",
    after = function (_)
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
            globals = { "nixCats", "vim" },
            disable = { "missing-fields" },
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
            command = { "nixfmt" },
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
    "nvim-jdtls",
  },
})

local jdtls = require("jdtls")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function ()
    local config = {
      cmd = { "jdtls" },
      root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw", "pom.xml" }),
      settings = {
        java = {
          contentProvider = { preferred = "cfr" },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          import = {
            maven = {
              enabled = true,
            },
            gradle = {
              enabled = true,
              wrapper = {
                enabled = true,
              },
            },
          },
          configuration = {
            runtimes = {
              {
                name = "JavaSE-1.8",
                path = "/nix/store/nx0by8kcvar65ksp49z246q1v2j7jsab-openjdk-8u442-b06/",
              },
              {
                name = "JavaSE-21",
                path = "/nix/store/k7sl9awa4r5i8z3fj8wz90cac1v7s5n7-openjdk-21.0.5+11/lib/openjdk/",
              },
            },
          },
        },
      },
      init_options = {
        bundles = {
          "/home/indi/Development/Java/vscode-java-decompiler/server/dg.jdt.ls.decompiler.cfr-0.0.3.jar",
          "/home/indi/Development/Java/vscode-java-decompiler/server/dg.jdt.ls.decompiler.common-0.0.3.jar",
          "/home/indi/Development/Java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.2.jar",
        },
        extendedClientCapabilities = jdtls.extendedClientCapabilities,
      },
      on_attach = function ()
        require("LSPs.on_attach")()
        -- jdtls.setup_dap()
      end,
    }
    jdtls.start_or_attach(config)
  end,
})
