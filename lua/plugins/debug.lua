return {
  {
    "nvim-dap",
    load = function (name)
      vim.cmd.packadd(name)
      vim.cmd.packadd("nvim-dap-ui")
      vim.cmd.packadd("nvim-dap-virtual-text")
    end,
    after = function (plugin)
      local dap = require("dap")
      local dapui = require("dapui")

      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
      vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set(
        "n",
        "<leader>db",
        dap.toggle_breakpoint,
        { desc = "Debug: Toggle Breakpoint" }
      )
      vim.keymap.set("n", "<leader>dB", function ()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Set Breakpoint" })
      vim.keymap.set(
        "n",
        "<F7>",
        dapui.toggle,
        { desc = "Debug: See last session result." }
      )
      vim.keymap.set("n", "<leader>da", function ()
        require("dap").run({
          type = "java",
          request = "attach",
          name = "Debug (Attach) - Remote",
          hostName = "localhost",
          port = 5005,
        })
      end, { desc = "Debug: Attach to remote" })

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      dap.configurations.java = {
        {
          type = "java",
          request = "attach",
          name = "Debug (Attach) - Remote",
          hostName = "127.0.0.1",
          port = 5005,
        },
      }

      require("nvim-dap-virtual-text").setup({
        enable_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        clear_on_continue = false,

        display_callback = function (variable, buf, stackframe, node, options)
          if options.virt_text_pos == "inline" then
            return " = " .. variable.value
          else
            return variable.name .. " = " .. variable.value
          end
        end,
      })
    end,
  },
  {
    "nvim-nio",
    dep_of = { "nvim-dap" },
  },
}
