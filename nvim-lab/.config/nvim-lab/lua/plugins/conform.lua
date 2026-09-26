return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters = {
      latexindent = {
        args = { "-m", "-l", vim.fn.expand("~/.config/nvim-lab/latexindent.yaml"), "-" },
      },
    },
    formatters_by_ft = {
      python = { "black" },
      cpp = { "clang_format" },
      c = { "clang_format" },
      lua = { "stylua" },
      tex = { "latexindent" },
      rust = { "rustfmt" },
    },
    format_on_save = {
      timeout_ms = 1000,
      lsp_fallback = true,
    },
  },
}
