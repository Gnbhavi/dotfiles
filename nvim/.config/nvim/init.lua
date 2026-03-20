-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- --- Line Wrap ---
vim.opt.wrap = true
vim.opt.linebreak = true -- wrap without breaking words
vim.opt.showbreak = "↪ " -- nice indicator for wrapped lines
-- ------------------
