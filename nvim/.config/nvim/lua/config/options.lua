-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- ------------------
-- --- Tabstop ---
vim.opt.expandtab = false -- Use actual tabs, not spaces
vim.opt.tabstop = 4 -- Render tabs as 4 spaces wide
vim.opt.shiftwidth = 4 -- Size of an indent

-- --- Line Wrap ---
vim.opt.wrap = true
vim.opt.linebreak = true -- wrap without breaking words
vim.opt.showbreak = "↪ " -- nice indicator for wrapped lines

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.breakindent = true
    vim.opt_local.showbreak = ""
  end,
})
