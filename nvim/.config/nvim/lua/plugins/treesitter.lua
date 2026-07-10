return {
	"nvim-treesitter/nvim-treesitter",
	-- Load treesitter early when opening a file from the cmdline
	lazy = vim.fn.argc(-1) == 0,
	-- Drastically improves startup time by lazy loading syntax highlighting
	-- and other nvim-treesitter features
	event = "VeryLazy",
	main = "nvim-treesitter.configs", -- Sets main module to use for opts
	build = ":TSUpdate",
	opts = {
		auto_install = true,
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"python",
			"javascript",
			"typescript",
			"html",
			"css",
			"json",
			"yaml",
			"markdown",
			"markdown_inline",
			"bash",
		},
		highlight = { enable = true, additional_vim_regex_highlighting = false },
		indent = { enable = true },
	},
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-context",
			config = function()
				-- vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = false })
				-- vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { underline = false })
				require("treesitter-context").setup({
					enable = true,
					max_lines = 3,
					min_window_height = 0,
					line_numbers = true,
					multiline_threshold = 3,
					trim_scope = "outer",
					mode = "cursor", -- 'cursor' or 'topline'
					separator = nil,
					zindex = 20,
				})
			end,
		},
	},
	-- config = function()
	--   local config = require('nvim-treesitter.configs')
	--   config.setup({
	--     auto_install = true,
	--     highlight = { enable = true, additional_vim_regex_highlighting = false },
	--     indent = { enable = true }
	--   })
	-- end
}
