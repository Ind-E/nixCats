return {
  {
    "telescope.nvim",
    cmd = { "Telescope" },
    on_require = { "telescope" },
    event = "DeferredUIEnter",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "[f]iles" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "[d]iagnostics" },
      { "<leader>rg", "<cmd>Telescope live_grep<CR>", desc = "[g]rep" },
      { "<leader>fw", "<cmd>Telescope grep_string<CR>", desc = "[w]ord" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "[b]uffers" },
      { "<leader>fr", "<cmd>Telescope resume<CR>", desc = "[r]esume" },
      { "<leader>fgC", "<cmd>Telescope git_commits<CR>", desc = "[C]ommits" },
      { "<leader>fgb", "<cmd>Telescope git_commits<CR>", desc = "[b]ranches" },
      { "<leader>fgf", "<cmd>Telescope git_files<CR>", desc = "[f]iles" },
      {
        "<leader>fgc",
        "<cmd>Telescope git_bcommits<CR>",
        desc = "buffer [c]ommits",
      },
      {
        "<leader>fc",
        "<cmd>Telescope command_history<CR>",
        desc = "[c]ommand history",
      },
      {
        "<leader>fz",
        "<cmd>Telescope current_buffer_fuzzy_find<CR>",
        desc = "fu[z]zy find",
      },
      { "<leader>ft", "<cmd>Telescope tags<CR>", desc = "[t]ags" },
      { "<leader>fc", "<cmd>Telescope git_bcommits<CR>", desc = "[c]ommits" },
      {
        "<leader>fs",
        "<cmd>Telescope lsp_document_symbols<CR>",
        desc = "[s]ymbols",
      },
      {
        "<leader>f/",
        "<cmd>Telescope search_history<CR>",
        desc = "[/] search history",
      },
      { "<leader>fq", "<cmd>Telescope quickfix<CR>", desc = "[q]uick fix" },
      { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "[o]ld files" },
    },
    after = function ()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
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
