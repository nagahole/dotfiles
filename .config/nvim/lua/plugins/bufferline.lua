return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer tab" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer tab" },
      {
        "<S-x>",
        function()
          local buf = vim.api.nvim_get_current_buf()
          -- Swap the window to another buffer first so :bdelete doesn't close the split
          if #vim.fn.getbufinfo({ buflisted = 1 }) > 1 then
            vim.cmd("bprevious")
          else
            vim.cmd("enew")
          end
          vim.cmd("bdelete " .. buf)
        end,
        desc = "Close current buffer",
      },
    },
    config = function()
      require("bufferline").setup({
        options = {
	  always_show_bufferline = true,

	  -- Don't sit on top of neotree
          offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "left", -- "left", "center", or "right"
            separator = true,
          },
          {
            filetype = "neo-tree-popup",
            text = "File Explorer",
            text_align = "left",
            separator = true,
          }}
        }
      })
    end,
  }
}
