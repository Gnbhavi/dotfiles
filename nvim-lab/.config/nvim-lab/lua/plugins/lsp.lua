-- return {
--   "neovim/nvim-lspconfig",
--   dependencies = { "williamboman/mason.nvim" },
--   config = function()
--     vim.lsp.enable("pyright")
--   end,
-- }
return {
  "neovim/nvim-lspconfig",
  dependencies = { "williamboman/mason.nvim" },
  config = function()
    vim.lsp.enable("pyright")
    vim.lsp.enable("clangd")
    vim.lsp.enable("lua_ls")
    vim.diagnostic.config({
      underline = true,
      virtual_text = true,
      signs = true,
    })

    vim.api.nvim_create_autocmd("DiagnosticChanged", {
      callback = function(args)
        local diagnostics = vim.diagnostic.get(args.buf)
        if #diagnostics > 0 then
          vim.notify(#diagnostics .. " diagnostic(s) found", vim.log.levels.INFO)
        end
        vim.cmd("redraw")
      end,
    })
  end,
}

