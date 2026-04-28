return {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- load this before all other plugins
    config = function()
      -- 🎨 Your Theme Setup
      vim.opt.termguicolors = true
      vim.opt.background = "dark"

      -- Load the colorscheme
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  -- If you wanted to try Oxocarbon instead, you'd add it like this:
  -- { "nyoom-engineering/oxocarbon.nvim" }
}
