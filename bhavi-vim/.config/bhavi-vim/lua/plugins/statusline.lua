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

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
  opts = {
    options = {
      theme = require("catppuccin.utils.lualine")(),
      component_separators = "|",
      section_separators = "",
      globalstatus = true,
      refresh = { statusline = 1000 }, -- so the clock actually ticks, not just on cursor move
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diagnostics" },
      lualine_c = { "filename", "aerial"},
      lualine_x = { "venv-selector", get_wordcount },
      lualine_y = { "filetype", "location" },
      lualine_z = {
          function() return "\u{f0954} " .. os.date("%H:%M") end,
      },
    },
  },
}
