-- spell check
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"

-- all spell errors in blue
vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = "#55aaff" })
vim.api.nvim_set_hl(0, "SpellCap", { undercurl = true, sp = "#55aaff" })
vim.api.nvim_set_hl(0, "SpellRare", { undercurl = true, sp = "#55aaff" })
vim.api.nvim_set_hl(0, "SpellLocal", { undercurl = true, sp = "#55aaff" })

-- <leader>k: spell suggestions or diagnostic popup
vim.keymap.set("n", "<leader>k", function()
  local word = vim.fn.expand("<cword>")
  local suggestions = vim.fn.spellsuggest(word, 5)
  if #suggestions == 0 then
    vim.diagnostic.open_float()
  else
    vim.ui.select(suggestions, {
      prompt = "Spell suggestions for: " .. word,
    }, function(choice)
      if choice then
        vim.cmd("normal! ciw" .. choice)
      end
    end)
  end
end, { buffer = true, desc = "Spell suggestions or diagnostic" })
