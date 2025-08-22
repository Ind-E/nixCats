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
      require("mini.files").setup({
        mappings = {
          close = "<ESC>",
        },
      })

      local minifiles_toggle = function (...)
        if not MiniFiles.close() then
          MiniFiles.open(...)
        end
      end

      vim.keymap.set("n", "<leader>i", minifiles_toggle, { desc = "f[i]les" })

      local show_dotfiles = true

      local filter_show = function (fs_entry)
        return true
      end

      local filter_hide = function (fs_entry)
        return not vim.startswith(fs_entry.name, ".")
      end

      local toggle_dotfiles = function ()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        MiniFiles.refresh({ content = { filter = new_filter } })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function (args)
          local buf_id = args.data.buf_id
          vim.keymap.set("n", ".", toggle_dotfiles, { buffer = buf_id })
        end,
      })
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
