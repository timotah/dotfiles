return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',         -- Required dependency
      -- Suggested dependencies (optional)
      { 'BurntSushi/ripgrep' },           -- Required for live_grep and grep_string
      { 'nvim-telescope/telescope-fzf-native.nvim' },
      { 'sharkdp/fd'}
    },
    tag = '0.1.8',
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    end
  },
  -- used for telescope codeactions gui for <leader>ca
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  }
}

