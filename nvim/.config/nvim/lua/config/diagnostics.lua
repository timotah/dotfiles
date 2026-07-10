local icons = {
  error = "",
  warn  = "",
  hint  = "",
  info  = "",
}

vim.diagnostic.config({
  virtual_text = false, -- No inline error text
  virtual_lines = false, -- No virtual lines
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.error,
      [vim.diagnostic.severity.INFO] = icons.info,
      [vim.diagnostic.severity.WARN] = icons.warn,
      [vim.diagnostic.severity.HINT] = icons.hint
    }
  },
  underline = true, -- Underline errors/warnings
  update_in_insert = false, -- Don't update diagnostics while typing
  severity_sort = true, -- Sort by severity
})

vim.lsp.set_log_level("warn")

-- Keymaps for diagnostics
-- local opts = { noremap=true, silent=true }
-- vim.keymap.set("n", "<leader>xn", vim.diagnostic.jump({ count = 1, float = true}), opts)
-- vim.keymap.set("n", "<leader>xp", vim.diagnostic.jump({ count = -1, float = true}), opts)
