return {
  {
    "telescope.nvim",
    cmd = { "Telescope" },
    on_require = { "telescope" },
    event = "DeferredUIEnter",
    keys = {
      { "<leader>d", "<cmd>Telescope diagnostics<CR>", desc = "[d]iagnostics" },

      -- helix
      { "<leader>b", "<cmd>Telescope buffers<CR>", desc = "[b]uffers" },
      { "gr", "<cmd>Telescope lsp_references<CR>", desc = "[g]oto [r]eferences" },
      { "<leader>j", "<cmd>Telescope jumplist<CR>", desc = "[b]uffers" },
      {
        "<leader>s",
        "<cmd>Telescope lsp_document_symbols<CR>",
        desc = "document [s]ymbols",
      },
      {
        "<leader>S",
        "<cmd>Telescope lsp_workspace_symbols<CR>",
        desc = "workspace [S]ymbols",
      },
      {
        "<leader>/",
        function ()
          local git_dir = vim.fn.system(
            string.format(
              "git -C %s rev-parse --show-toplevel",
              vim.fn.expand("%:p:h")
            )
          )
          git_dir = string.gsub(git_dir, "\n", "") -- remove newline character from git_dir
          local opts = {
            cwd = git_dir,
          }
          require("telescope.builtin").live_grep(opts)
        end,
        desc = "[g]rep",
      },
      { "<leader>'", "<cmd>Telescope resume<CR>", desc = "[r]esume" },

      { "<leader>gfC", "<cmd>Telescope git_commits<CR>", desc = "[C]ommits" },
      { "<leader>gfb", "<cmd>Telescope git_commits<CR>", desc = "[b]ranches" },
      {
        "<leader>f",
        function ()
          local _ = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null")
          if vim.v.shell_error == 0 then
            require("telescope.builtin").git_files()
          else
            require("telescope.builtin").find_files()
          end
        end,
        desc = "[f]iles",
      },
      {
        "<leader>gfc",
        "<cmd>Telescope git_bcommits<CR>",
        desc = "buffer [c]ommits",
      },
      {
        "<leader>hc",
        "<cmd>Telescope command_history<CR>",
        desc = "[c]ommand history",
      },
      {
        "<leader>h/",
        "<cmd>Telescope search_history<CR>",
        desc = "[/] search history",
      },
      {
        "<leader>z",
        "<cmd>Telescope current_buffer_fuzzy_find<CR>",
        desc = "fu[z]zy find",
      },
      { "<leader>k", "<cmd>Telescope quickfix<CR>", desc = "[q]uick fix" },
      { "<leader>l", "<cmd>Telescope oldfiles<CR>", desc = "[o]ld files" },
    },
    after = function ()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
        defaults = {
          layout_config = {
            prompt_position = "top",
          },
          sorting_strategy = "ascending",
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "telescope-ui-select.nvim",
    dep_of = { "telescope.nvim" },
  },
}
