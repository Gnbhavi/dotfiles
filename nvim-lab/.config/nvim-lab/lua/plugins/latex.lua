return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_view_automatic = 0  -- (3) don't auto-open Zathura, only on keypress

    vim.g.vimtex_compiler_latexmk = {
      continuous = 1,     -- (1) watches the file, recompiles automatically on save
      out_dir = "output", -- (2) log/aux/pdf all land in "output/", not touching latexmkrc
    }
  end,
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "tex",
      callback = function()
        -- (2) ensure the output folder exists before compiling into it
        vim.fn.mkdir(vim.fn.expand("%:p:h") .. "/output", "p")
        -- (1) start the auto-compiling watcher the moment you open a .tex file,
        -- so you don't have to manually trigger it first
        vim.cmd("VimtexCompile")
      end,
    })
  end,
}
