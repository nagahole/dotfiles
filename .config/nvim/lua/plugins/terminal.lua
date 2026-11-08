return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 15,                -- Height of the bottom pane
      open_mapping = [[<C-\>]], -- Shortcut: Press Ctrl + \ to open/close it
      direction = "horizontal", -- Forces it to the bottom
    })
    
    -- Press Esc twice inside the terminal to easily get back to editing code
    vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })
  end,
}

