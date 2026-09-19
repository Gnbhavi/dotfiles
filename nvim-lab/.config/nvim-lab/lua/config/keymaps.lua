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
