return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
  },
  ft = "python",
  opts = {
    search = {
      my_venvs = {
        command = "fd '/bin/python$' $PYTHON_VENV_ROOT --full-path --color never",
      },
    },
  },
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python venv" },
    {
      "<leader>vp",
      function()
        vim.ui.input({ prompt = "Path to search for venvs: " }, function(path)
          if not path or path == "" then
            return
          end
          path = vim.fn.expand(path)
          require("venv-selector").setup({
            search = {
              manual_path = {
                command = "fd '/bin/python$' '" .. path .. "' --full-path --color never",
              },
            },
          })
          vim.cmd("VenvSelect")
        end)
      end,
      desc = "Select venv from pasted path",
    },
  },
}
