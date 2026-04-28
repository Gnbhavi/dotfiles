return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    options = {
      mode = "buffers",
      numbers = "none",
      indicator = { style = "none" }, -- Keeps the active tab looking incredibly clean
      show_buffer_close_icons = false, -- Ascetic mode: no clicking "x" to close
      show_close_icon = false,
      color_icons = true,
      separator_style = "thin",
      always_show_bufferline = true,
    }
  }
}
