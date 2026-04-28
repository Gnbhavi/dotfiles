return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim", -- This is the engine that draws that beautiful floating box!
  },
  opts = {
    close_if_last_window = true,
    
    -- THIS IS THE MAGIC SWITCH! It forces Neo-tree to use floating boxes for everything.
    use_popups_for_input = false, 
    popup_border_style = "rounded", -- Gives the box those smooth curved corners from your image
    
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = true,
        hide_gitignored = true,
      },
    },
  },
}
