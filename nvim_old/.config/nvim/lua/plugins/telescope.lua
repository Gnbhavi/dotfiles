return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Integrates fzf syntax and sorting directly into Telescope
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    -- The require statement is now safely inside the config function!
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        prompt_prefix = "🔍 ",
        selection_caret = "➤ ",
        path_display = { "smart" },

        -- Ignore common clutter
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "venv",
          "__pycache__",
          "%.lock",
        },

        -- Layout
        layout_config = {
          horizontal = { preview_width = 0.6 },
          vertical = { mirror = false },
        },

        -- Sorting
        sorting_strategy = "ascending",
        layout_strategy = "flex",
      },

      pickers = {
        find_files = {
          hidden = true, -- show hidden files
        },
        live_grep = {
          -- nothing fancy yet, but can add ripgrep args later
        },
      },
    })

    -- Load the fzf extension to override the default sorter
    telescope.load_extension("fzf")
  end,
}
-- -- telescope.lua
-- -- 🔭 Telescope Config
--
-- local telescope = require("telescope")
--
-- telescope.setup({
--   defaults = {
--     prompt_prefix = "🔍 ",
--     selection_caret = "➤ ",
--     path_display = { "smart" },
--
--     -- Ignore common clutter
--     file_ignore_patterns = {
--       "node_modules",
--       ".git/",
--       "venv",
--       "__pycache__",
--       "%.lock",
--     },
--
--     -- Layout
--     layout_config = {
--       horizontal = { preview_width = 0.6 },
--       vertical = { mirror = false },
--     },
--
--     -- Sorting
--     sorting_strategy = "ascending",
--     layout_strategy = "flex",
--   },
--
--   pickers = {
--     find_files = {
--       hidden = true, -- show hidden files
--     },
--     live_grep = {
--       -- nothing fancy yet, but can add ripgrep args later
--     },
--   },
-- })
--
-- -- Load Telescope extensions if you add them later
-- -- telescope.load_extension("fzf")
