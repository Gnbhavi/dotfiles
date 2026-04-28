return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		-- 1. A clean, minimal ascetic logo
		dashboard.section.header.val = {
			[[                                  ]],
			[[    ███╗   ██╗██╗   ██╗██╗███╗   ███╗    ]],
			[[    ████╗  ██║██║   ██║██║████╗ ████║    ]],
			[[    ██╔██╗ ██║██║   ██║██║██╔████╔██║    ]],
			[[    ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║    ]],
			[[    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║    ]],
			[[    ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝    ]],
			[[                                  ]],
		}

		-- 2. Define the main buttons to match YOUR configuration
		dashboard.section.buttons.val = {
			dashboard.button("n", "  New File", "<cmd>ene <BAR> startinsert <CR>"),
			dashboard.button("f f", "  Find File (Telescope)", "<cmd>Telescope find_files<CR>"),
			dashboard.button("f g", "󰊄  Live Grep (Search Text)", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("Space e", "  Open File Explorer", "<cmd>Neotree toggle left<CR>"),
			dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
		}

		-- 3. Spacing and Layout
		dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"

		-- Add a little footer message
		dashboard.section.footer.val = "Ascetic Workflow Enabled."
		dashboard.section.footer.opts.hl = "AlphaFooter"

		local layout = {
			{ type = "padding", val = 4 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 2 },
			dashboard.section.footer,
		}

		dashboard.config.layout = layout

		-- 4. Load the dashboard
		alpha.setup(dashboard.config)
	end,
}
