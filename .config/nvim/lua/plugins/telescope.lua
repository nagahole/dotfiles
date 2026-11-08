return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    -- Active buffers
    { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Search Open Buffers" },
    -- Project files
    { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Search Project Files"},
    -- All text
    { "<leader>t", "<cmd>Telescope live_grep<cr>", desc = "Search All Text"},
    -- Errors and warnings
    { "<leader>d", "<cmd>Telescope diagnostics<cr>", desc = "Search Diagnostics" },
  },
  opts = {
    defaults = {
      mappings = {
        n = { ["l"] = "select_default", ["h"] = "close" },
      },
    },
  },
}
