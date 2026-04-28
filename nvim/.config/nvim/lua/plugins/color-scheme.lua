return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000, -- Load this before all the other start plugins
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- The darkest, cleanest flavor
			transparent_background = true, -- Makes the background transparent to match your terminal
		})
		-- Apply the colorscheme
		vim.cmd.colorscheme("catppuccin")
	end,
}
