return {
  "nvim-lualine/lualine.nvim",
  config = function()
    -- local icons = dofile(vim.fn.stdpath('config') .. '/lua/config/diagnostics.lua')
    require("lualine").setup({
      options = {
        theme = "auto",
      },
      -- sections = {
      --   lualine_c = {
      --     {
      --       'diagnostics',
      --       sources = { 'nvim_diagnostic' },
      --       symbols = {
      --         error = icons.error,
      --         warn  = icons.warn,
      --         info  = icons.info,
      --         hint  = icons.hint,
      --       },
      --     },
      --   },
      -- },
      extensions = {
        'oil'
      }
    })
  end,
}
