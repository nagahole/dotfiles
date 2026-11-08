return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({ "c", "cpp" })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "c", "cpp" },
      -- pcall: parsers install async on first launch
      callback = function() pcall(vim.treesitter.start) end,
    })
  end,
}
