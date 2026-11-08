return {
  "christoomey/vim-tmux-navigator",
  -- Skip the default mappings: its <C-\> clashes with toggleterm
  init = function() vim.g.tmux_navigator_no_mappings = 1 end,
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>" },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>" },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>" },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>" },
  },
}
