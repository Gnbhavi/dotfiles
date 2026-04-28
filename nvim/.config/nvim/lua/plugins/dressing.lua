return {
  "stevearc/dressing.nvim",
  opts = {
    input = {
      -- This is the magic command that pulls it into the center of the entire editor
      relative = "editor", 
      border = "rounded",
      title_pos = "left",
      prefer_width = 40,
    },
    -- We disable the select menu override so Telescope keeps doing its job
    select = {
      enabled = false, 
    }
  },
}
