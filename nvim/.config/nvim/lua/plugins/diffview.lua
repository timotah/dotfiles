return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  keys = {
    { "<leader>do", "<cmd>DiffviewOpen<cr>",            desc = "Diff working tree" },
    { "<leader>dO", "<cmd>DiffviewOpen HEAD<cr>",        desc = "Diff against HEAD" },
    { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>",    desc = "File history (current file)" },
    { "<leader>dH", "<cmd>DiffviewFileHistory<cr>",      desc = "File history (repo)" },
    { "<leader>dx", "<cmd>DiffviewClose<cr>",            desc = "Close diffview" },
    -- visual mode: trace history of selected lines
    { "<leader>dv", ":'<,'>DiffviewFileHistory<cr>",     desc = "Line history", mode = "v" },
  },
  config = function()
    require("diffview").setup({
      enhanced_diff_hl = true,
      use_icons = true,
      watch_index = true, -- auto-refresh when git index changes (e.g. after staging)
      view = {
        default = {
          winbar_info = true,
          disable_diagnostics = true, -- lsp squiggles in diff panes are noisy
        },
        merge_tool = {
          layout = "diff3_horizontal",
          winbar_info = true,
          disable_diagnostics = true,
        },
        file_history = {
          winbar_info = true,
          disable_diagnostics = true,
        },
      },
      file_panel = {
        listing_style = "tree",
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
        win_config = {
          position = "left",
          width = 35,
        },
      },
      hooks = {
        diff_buf_read = function(bufnr)
          -- keep diff panes clean
          vim.opt_local.wrap = false
          vim.opt_local.list = false
        end,
      },
    })
  end,
}
