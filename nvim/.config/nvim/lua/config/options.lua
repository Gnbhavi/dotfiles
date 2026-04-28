local opt = vim.opt
opt.number = true -- Show line numbers
opt.relativenumber = true -- Relative line numbers for fast jumping
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.wrap = true -- wrap lines
opt.termguicolors = true -- Enable true color support
opt.tabstop = 4 -- 4 spaces for tabs (good for Python/Rust)
opt.shiftwidth = 4
opt.expandtab = true -- Use spaces instead of tabs
vim.opt.pumheight = 7 -- Limits the popup menu to 7 items and makes it scrollable
vim.opt.fillchars = { eob = " " } -- Hide the annoying '~' symbols at the end of the file
-- ==========================================
-- AUTO COMMANDS (Templates & Rules)
-- ==========================================

-- Automatically insert a bash shebang and make the file executable when creating a new .sh file
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.sh",
  callback = function()
    -- Insert the template
    vim.api.nvim_buf_set_lines(0, 0, 0, false, { "#!/usr/bin/env bash", "", "" })
    -- Move the cursor to the 3rd line so you can start typing immediately
    vim.api.nvim_win_set_cursor(0, { 3, 0 })
  end,
})

-- Automatically add execution permissions to bash scripts on save
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.sh",
  callback = function()
    vim.fn.system("chmod +x " .. vim.fn.expand("%"))
  end,
})

