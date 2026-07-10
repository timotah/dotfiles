return {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    -- Map of filetype to formatters
    formatters_by_ft = {
      lua = { "stylua" },
      typescript = { "prettier" },
      javascript = { "prettier" },
      json = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      markdown = { "prettier" },
      yaml = { "prettier" },
      python = { "black" },
      htmlangular = { "prettier" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    log_level = vim.log.levels.ERROR,
    notify_on_error = true,
    notify_no_formatters = true,
  },
}
