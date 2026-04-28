return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- This line tells Lazy EXACTLY where to find the setup function, avoiding the path error
		main = "nvim-treesitter.config",
		-- Lazy will automatically pass these options to the setup function when it's perfectly ready
		opts = {
			ensure_installed = {
				"bash",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"rust",
				"latex",
			},
			highlight = { enable = true },
			indent = { enable = true },
		},
	},

	-- Automatically close pairs like () {} [] ""
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
}
