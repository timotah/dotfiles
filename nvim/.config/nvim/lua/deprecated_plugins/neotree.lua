 return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  lazy = false, -- neo-tree will lazily load itself
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    -- fill any relevant options here
  },
  config = function()
    vim.keymap.set('n', '<C-e>', function()
        local win_ids = vim.tbl_filter(function(win_id)
            local buf_id = vim.api.nvim_win_get_buf(win_id)
            local buf_name = vim.api.nvim_buf_get_name(buf_id)
            return buf_name:match("neo%-tree filesystem")
        end, vim.api.nvim_list_wins())

        if #win_ids > 0 then
            -- NeoTree is open
            local current_win = vim.api.nvim_get_current_win()
            if current_win == win_ids[1] then
                -- We're focused on NeoTree, so close it
                vim.cmd("Neotree close")
            else
                -- NeoTree is open but not focused, so focus it
                vim.api.nvim_set_current_win(win_ids[1])
            end
        else
            -- NeoTree is not open, so open it
            vim.cmd("Neotree filesystem reveal right")
        end
    end, { noremap = true, silent = true })
  end
}
