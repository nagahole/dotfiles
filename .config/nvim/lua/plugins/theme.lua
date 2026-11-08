return {
  "webhooked/kanso.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanso").setup({
      -- FIXED: Passed "ink" to dark since it is a dark mode flavor
      dark = "ink",            -- Options: "zen" | "mist" | "ink"
      light = "pearl",         -- Options: "pearl"
      foreground = "saturated",  -- Options: "default" | "saturated"
      minimal = false,
      transparent = true,
    })

    -- Forces Neovim to load the dark palette variant
    vim.o.background = "dark"
    vim.cmd("colorscheme kanso")
  end,
}

