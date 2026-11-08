-- Auto-reload files (mostly for Claude Code)
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  pattern = "*",
  command = "checktime",
})

-- Set space as the leader key
vim.g.mapleader = " "

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Blinking cursor in insert mode
vim.opt.guicursor:append("i:blinkwait700-blinkoff400-blinkon250")

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Indentation: spaces instead of tabs, 4 wide by default
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.makeprg = "cmake --build build -- -k"
  end,
})

-- Strip trailing whitespace on save, keeping the cursor where it was
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- macOS-style deletes in insert mode
vim.keymap.set("i", "<M-BS>", "<C-w>", { desc = "Delete word backward" })
vim.keymap.set("i", "<D-BS>", "<C-u>", { desc = "Delete to start of line" })

-- :q / :wq close the buffer instead of the last editor window, so Neo-tree doesn't take over
local function smart_quit(opts)
  local bang = opts.bang and "!" or ""
  local editor_wins = vim.tbl_filter(function(w)
    return vim.api.nvim_win_get_config(w).relative == ""
      and vim.bo[vim.api.nvim_win_get_buf(w)].buftype == ""
  end, vim.api.nvim_tabpage_list_wins(0))

  if #editor_wins > 1 or vim.bo.buftype ~= "" then
    vim.cmd("quit" .. bang)
  elseif #vim.fn.getbufinfo({ buflisted = 1 }) <= 1 then
    vim.cmd("qall" .. bang)
  elseif vim.bo.modified and not opts.bang then
    vim.notify("E37: No write since last change (add ! to override)", vim.log.levels.ERROR)
  else
    local buf = vim.api.nvim_get_current_buf()
    vim.cmd("bprevious")
    vim.cmd("bdelete" .. bang .. " " .. buf)
  end
end

vim.api.nvim_create_user_command("Q", smart_quit, { bang = true })
vim.api.nvim_create_user_command("Wq", function(opts)
  vim.cmd("write" .. (opts.bang and "!" or ""))
  smart_quit(opts)
end, { bang = true })
vim.cmd([[cnoreabbrev <expr> q getcmdtype() == ':' && getcmdline() ==# 'q' ? 'Q' : 'q']])
vim.cmd([[cnoreabbrev <expr> wq getcmdtype() == ':' && getcmdline() ==# 'wq' ? 'Wq' : 'wq']])

-- LSP
vim.lsp.config("clangd", {
  cmd = { "clangd" },
  filetypes = { "c", "cpp" },
  root_markers = { "compile_commands.json", ".git" },
})
vim.lsp.enable("clangd")

-- Keep the empty [No Name] buffer as a blank placeholder: off the bufferline, wiped once a file replaces it.
-- Once you type into it, it becomes a normal buffer so nothing is lost.
vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "TextChanged", "TextChangedI" }, {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_get_name(buf) ~= "" or vim.bo[buf].buftype ~= "" then return end
    local blank = not vim.bo[buf].modified and vim.api.nvim_buf_line_count(buf) == 1
      and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ""
    vim.bo[buf].buflisted = not blank
    -- "delete" not "wipe": :restart's session restore wipes the startup buffer itself and errors if it's already gone
    vim.bo[buf].bufhidden = blank and "delete" or ""
  end,
})
-- Terminals start as blank buffers, so undo the above or hiding one kills its shell
vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal bufhidden=" })

-- Only show tabs when multiple
vim.opt.showtabline = 1


-- PACKAGE MANAGER -------------------------------------------------------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Initialize with the folder import
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
})
