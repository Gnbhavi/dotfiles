return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300 -- How long it waits (in ms) before popping up the menu
	end,
	opts = {
    preset = "helix", -- This magic word snaps the menu to the right side of your screen!
    win = {
      border = "rounded", -- Adds those slight, ascetic rounded corners
      padding = { 1, 2 }, -- Gives the text just a little bit of breathing room
    },
  },
}
