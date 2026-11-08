return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    chunk = {
      enable = true,
      delay = 0,
      duration = 50,
      chars = { right_arrow = "─" },
    },
  },
}
