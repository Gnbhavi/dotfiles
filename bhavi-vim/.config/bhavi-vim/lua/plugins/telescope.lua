return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep in files" },
    { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Find open buffer" },
    { "<leader>fm", "<cmd>Telescope aerial<cr>", desc = "Jump to heading/symbol" },
},
}
