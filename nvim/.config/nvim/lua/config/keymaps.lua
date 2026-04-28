local keymap = vim.keymap

vim.g.mapleader = " " -- Set Space as the leader key
vim.g.maplocalleader = "\\"

-- Clear search highlights on pressing <Esc>
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Better Window Navigation (use Ctrl + hjkl to move between splits)
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window Splitting
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Buffers (Tabs)
keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Save and Quit shortcuts
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save File" })
keymap.set("n", "<leader>q", "<cmd>qa<CR>", { desc = "Quit All" })

-- ==========================================
-- PLUGIN SHORTCUTS
-- ==========================================

-- Neo-tree (File Explorer)
keymap.set("n", "<leader>e", "<cmd>Neotree toggle left<CR>", { desc = "Toggle File Explorer" })

-- Telescope (Fuzzy Finder)
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files(Names Telescope)" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep(Search text)" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find Buffers" })

-- LazyGit
keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })
