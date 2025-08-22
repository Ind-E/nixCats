return {
  {
    "mini.trailspace",
    event = "DeferredUIEnter",
    after = function ()
      require("mini.trailspace").setup({})

      vim.g.trim_trailing_ws_on_save = true

      vim.keymap.set("n", "<leader>tt", function ()
        vim.g.trim_trailing_ws_on_save = not vim.g.trim_trailing_ws_on_save
        print("Trim on save: " .. (vim.g.trim_trailing_ws_on_save and "ON" or "OFF"))
      end, { noremap = true, desc = "Toggle trim whitespace on save" })

      vim.keymap.set("n", "<leader>tw", function ()
        require("mini.trailspace").trim()
      end, { noremap = true, desc = "Trim whitespace now" })

      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function ()
          if vim.g.trim_trailing_ws_on_save then
            require("mini.trailspace").trim()
          end
        end,
      })
    end,
  },
  {
    "mini.surround",
    event = "DeferredUIEnter",
    after = function ()
      require("mini.surround").setup()
    end,
  },
  {
    "mini.splitjoin",
    event = "DeferredUIEnter",
    after = function ()
      require("mini.splitjoin").setup()
    end,
  },
  {
    "mini.ai",
    event = "DeferredUIEnter",
    after = function ()
      require("mini.ai").setup()
    end,
  },
  {
    "mini.align",
    event = "DeferredUIEnter",
    after = function ()
      require("mini.align").setup()
    end,
  },
  {
    "mini.files",
    event = "DeferredUIEnter",
    after = function ()
      require("mini.files").setup()
    end,
  },
  {
    "mini.pairs",
    event = "DeferredUIEnter",
    after = function ()
      require("mini.pairs").setup({
        mappings = {
          ["("] = false,
          [")"] = false,
          ["["] = false,
          ["]"] = false,
          ['"'] = false,
          ["'"] = false,
          ["`"] = false,
        },
      })
    end,
  },
}
