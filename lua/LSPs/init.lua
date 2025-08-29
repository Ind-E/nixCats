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
    "tinymist",
    lsp = {
      on_attach = require("LSPs.on_attach"),
    },
  },
  {
    "clangd",
    lsp = {},
  },
  {
    "kotlin_language_server",
    lsp = {
      settings = {
        -- root_dir =
      },
    },
  },
  {
    "lemminx",
    lsp = {},
  },
  {
    "basedpyright",
    lsp = {
      on_attach = require("LSPs.on_attach"), -- idk why this is needed
      settings = {
        basedpyright = {
          analysis = {
            diagnosticSeverityOverrides = {
              reportUnusedExpression = "none",
            },
            typeCheckingMode = "basic",
          },
        },
      },
    },
  },
  {
    "rust_analyzer",
    lsp = {},
  },
  {
    "taplo",
    on_plugin = "lspconfig",
    lsp = {
      filetypes = { "toml" },
      cmd = { "taplo", "lsp", "stdio" },
      settings = {
        single_file_support = true,
      },
    },
  },
  {
    "crates.nvim",
    event = "BufRead Cargo.toml",
    after = function ()
      local crates = require("crates")
      crates.setup({
        lsp = {
          enabled = true,
          on_attach = function (client, bufnr)
            require("LSPs.on_attach")()
          end,
          actions = true,
          completion = true,
          hover = true,
        },
      })
      vim.keymap.set("n", "<leader>cf", function ()
        crates.show_features_popup()
        crates.focus_popup()
      end, { silent = true, desc = "[f]eatures popup" })
      vim.keymap.set("n", "<leader>cv", function ()
        crates.show_versions_popup()
        crates.focus_popup()
      end, { silent = true, desc = "[v]ersions popup" })
      vim.keymap.set("n", "<leader>cd", function ()
        crates.show_dependencies_popup()
        crates.focus_popup()
      end, { silent = true, desc = "[d]ependencies popup" })
      vim.keymap.set("n", "<leader>cu", function ()
        crates.upgrade_crate()
      end, { silent = true, desc = "[u]pgrade crate" })
      vim.keymap.set("n", "<leader>cU", function ()
        crates.upgrade_all_crates()
      end, { silent = true, desc = "[U]pgrade all crates" })
      require("which-key").add({
        { "<leader>c", group = "[c]rates" },
      })
    end,
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
    "jsonls",
    lsp = {},
  },
  {
    "nvim-jdtls",
  },
  {
    "roslyn.nvim",
    after = function ()
      require("roslyn.nvim").setup({})
    end,
  },
})

-- rust-analyzer is installed with rustup
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = require("LSPs.on_attach"),
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
                path = nixCats.extra["jdk8-path"],
              },
              {
                name = "JavaSE-21",
                path = "/run/current-system/sw/lib/openjdk",
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
