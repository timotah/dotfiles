return {
	"saghen/blink.cmp",
	version = "1.*",
	-- `main` is untested, please open a PR if you've confirmed it works as expected
	dependencies = { "rafamadriz/friendly-snippets" },
	opts = {
		keymap = {
			preset = "default",
			-- ['<C-n>'] = { 'next_item' },
			-- ['<C-p>'] = { 'prev_item' },
			-- ['<C-y>'] = { 'accept', 'accept_word', 'accept_line' },
			-- ['<C-c>'] = { 'cancel' },
			-- ['<C-d>'] = { 'scroll_down' },
			-- ['<C-u>'] = { 'scroll_up' },
			-- ['<C-f>'] = { 'show_menu', 'hide_menu' },
			-- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
			-- ['<C-e>'] = { 'hide' },
			-- ...other mappings as needed
		},
		completion = {
			documentation = {
				auto_show = true,
			},
			menu = {
				auto_show = true,
			},
			ghost_text = {
				enabled = false,
			},
		},
		cmdline = {
			keymap = {
				['<C-n>'] = { 'select_next' },
				['<C-p>'] = { 'select_prev' },
				['<C-y>'] = { 'accept' },
				['<Up>'] = { 'fallback' },
				['<Down>'] = { 'fallback' },
				['<Left>'] = { 'fallback' },
				['<Right>'] = { 'fallback' },
				['<CR>'] = { 'fallback' },
			},
			completion = { menu = { auto_show = true } },
		},
		snippets = { preset = "default" },
		-- ensure you have the `snippets` source (enabled by default)
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				lsp = {
					name = "LSP",
					enabled = true,
					async = true,
					timeout_ms = 500,
				},
				snippets = {
					opts = {
						friendly_snippets = true,
						extended_filetypes = {
							typescript = { "javascript" },
							htmlangular = { "html" },
						},
					},
				},
			},
		},
	},
}
