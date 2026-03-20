return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- 🛑 THIS is where we force LazyVim to turn off the inline text globally
      diagnostics = {
        virtual_text = false,
        underline = true,
        update_in_insert = false,
      },
      -- Here is your Texlab server setup
      servers = {
        texlab = {
          settings = {
            texlab = {
              chktex = {
                onOpenAndSave = true,
                onEdit = true,
              },
            },
          },
        },
      },
    },
  },
}
