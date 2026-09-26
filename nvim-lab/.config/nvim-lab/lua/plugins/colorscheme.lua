return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
    transparent_background = true,
    integrations = {
      blink_cmp = true,
      telescope = true,
      which_key = true,
      native_lsp = { enabled = true },
      treesitter = true,
      mason = true,
      lualine = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
