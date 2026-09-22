-- Base configuration
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = "Save file" })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = "Quit file"})
vim.keymap.set('i', 'jk', '<Esc>', { desc = "Enter normal mode"})

-- Buffer Navigation
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = "Next buffer"})
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { desc = "Previous buffer"})
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = "Close buffer"})

-- Window (split) navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move to left split" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Move to below split" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Move to above split" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move to right split" })

-- Telescope
vim.keymap.set('n', '<leader>us', ':set spell!<CR>', { desc = "Toggle spellcheck" })

-- Diagnostics
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostic at cursor" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set('n', '<leader>xl', vim.diagnostic.setloclist, { desc = "List all diagnostics (buffer)" })

vim.keymap.set('n', '<leader>ud', function()
  local bufnr = 0
  if vim.diagnostic.is_enabled({ bufnr = bufnr }) then
    vim.diagnostic.enable(false, { bufnr = bufnr })
    vim.notify("Diagnostics off", vim.log.levels.INFO)
  else
    vim.diagnostic.enable(true, { bufnr = bufnr })
    vim.diagnostic.show(nil, bufnr)
    vim.notify("Diagnostics on", vim.log.levels.INFO)
  end
end, { desc = "Toggle diagnostics" })
