-- return {
--   "nvim-lualine/lualine.nvim",
--   dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
--   opts = {
--     options = {
--       theme = require("catppuccin.utils.lualine")(),
--       globalstatus = true,
--     },
--     sections = {
--       lualine_a = { "mode" },
--       lualine_b = { "branch", "diff" },
--       lualine_c = { "filename" },
--       lualine_x = { "venv-selector", "diagnostics" },
--       lualine_y = { "filetype" },
--       lualine_z = { "location" },
--     },
--   },
-- }
--
-- Wordcount for .tex and .md
local function get_wordcount()
	local ft = vim.bo.filetype
	if ft ~= "tex" and ft ~= "markdown" then
		return ""
	end
	local wc = vim.fn.wordcount()
	if wc.words == 0 then
		return ""
	end
	return tostring(wc.words) .. " words"
end

-- CLI Focus Timer Reader
local function get_timer()
	local timer_file = "/tmp/focus_timer.txt"
	local f = io.open(timer_file, "r")
	if f then
		local time = f:read("*a")
		f:close()
		time = time:gsub("%s+", "")
		if time ~= "" then
			return "󱎫 " .. time
		end
	end
	return ""
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" , "catppuccin/nvim" },
	opts = {
		options = {
		    theme = require("catppuccin.utils.lualine")(),
			component_separators = "",
			section_separators = "",
			globalstatus = true,
		},
		-- Here is your custom layout!
		sections = {
			lualine_a = { "mode" }, -- Normal / Insert
			lualine_b = { "venv-selector","branch", "diagnostics" }, -- master | +42 -1
			lualine_c = { { "filename", path = 1 }, get_wordcount }, -- (Only shows up for .tex/.md)

			lualine_x = { "diff" }, -- Timer | python
			lualine_y = { "location", "progress" }, -- test.py
			lualine_z = { get_timer }, -- 42%
		},
	},
}
