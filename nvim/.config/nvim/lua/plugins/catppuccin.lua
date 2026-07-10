return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    terminal_colors = true,
    styles = {
      comments = { "italic" },
      -- conditionals = { "italic" },
      -- loops = { "italic" },
      -- functions = { "italic" },
      -- keywords = { "italic" },
      -- strings = {},
      -- variables = {},
      -- numbers = {},
      -- booleans = {},
      -- properties = {},
      -- types = {},
      -- operators = {},
    },
    integrations = {
      cmp = true,
      telescope = true,
      treesitter = true,
      oil = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
      },
    },
    custom_highlights = function(colors)
        return {
            LineNr = { fg = colors.subtext0 },
            CursorLineNr = { fg = colors.rosewater, bold = true },
        }
    end,
  }
}

