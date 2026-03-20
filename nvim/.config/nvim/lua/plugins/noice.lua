return {
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        enabled = false, -- disable fancy cmdline
      },
      popupmenu = {
        enabled = false, -- disable fancy popup (fixes completion position too)
      },
      messages = {
        enabled = false, -- critical: disable this too, or cmdline/input stays broken
      },
      notify = {
        enabled = true, -- keep nice pop-up notifications (top-right)
      },
      lsp = {
        progress = { enabled = false }, -- optional, disable if you hate LSP status spam
        signature = { enabled = false },
        hover = { enabled = false },
      },
      routes = { -- hide annoying spam messages
        { filter = { event = "msg_show", kind = { "written" } }, opts = { skip = true } },
        { filter = { event = "msg_show", find = "%d+/%d+" }, opts = { skip = true } }, -- search counts
        { filter = { event = "msg_show", find = "^Hunk" }, opts = { skip = true } }, -- git hunks if noisy
      },
    },
  },
}
