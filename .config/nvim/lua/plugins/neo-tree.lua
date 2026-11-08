return {
  "nvim-neo-tree/neo-tree.nvim", -- Fixed the repository name typo here!
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  -- Sessions (e.g. :restart) can't restore Neo-tree and bring it back as a plain buffer
  init = function()
    vim.api.nvim_create_autocmd("SessionLoadPost", {
      callback = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_get_name(buf):match("neo%-tree ") and vim.bo[buf].filetype ~= "neo-tree" then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
      end,
    })
  end,
  -- Lazy-load Neo-tree by binding the trigger keys here
  keys = {
    { "<leader>e", "<cmd>Neotree toggle left<CR>", desc = "Toggle File Explorer", mode = "n" },
  },
  opts = {
    -- Pick up changes made outside nvim (e.g. git commit in the terminal)
    filesystem = { use_libuv_file_watcher = true },
    window = {
      width = 30,
      mappings = {
        -- Map 'l' to open a file or expand a folder
        ["l"] = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" then
            if not node:is_expanded() then
              state.commands["toggle_node"](state)
            else
              vim.cmd("normal! j")
            end
          else
            state.commands["open"](state)
          end
        end,
        -- Map 'h' to collapse a folder
        ["h"] = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" and node:is_expanded() then
            state.commands["toggle_node"](state)
          end
        end,
      },
    },
  },
}
