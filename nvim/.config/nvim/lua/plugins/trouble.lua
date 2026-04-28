return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    use_diagnostic_signs = true, 
    action_keys = {
      close = "q", 
      cancel = "<esc>",
    },
  },
  keys = {
    -- Current File Only (The clean, ascetic way!)
    { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document Diagnostics" },
    
    -- Whole Project (Just in case you need to check the big picture)
    { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics" },
  },
}
