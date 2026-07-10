-- Function loads omarchy current theme and adjusts neovim 
-- If wanting the color switch logic, remove the theme_file = nil and uncomment the line above it finding the theme/neovim.lua
-- local theme_file = vim.fn.expand("~/.config/omarchy/current/theme/neovim.lua")
local theme_file = nil
local colorscheme_to_load = nil

-- Read the Omarchy theme file to extract colorscheme
if vim.fn.filereadable(theme_file) == 1 then
	local ok, theme_plugins = pcall(dofile, theme_file)
	if ok and type(theme_plugins) == "table" then
		for _, plugin in ipairs(theme_plugins) do
      -- print here
			if
				type(plugin) == "table"
				and plugin[1] == "LazyVim/LazyVim"
				and plugin.opts
				and plugin.opts.colorscheme
			then
				colorscheme_to_load = plugin.opts.colorscheme
				break
			end
		end
	end
end

-- Map Omarchy colorscheme names to actual plugins
local theme_specs = {
	catppuccin = {
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
		},
		config = function(plugin, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	["catppuccin-latte"] = {
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "latte",
			})
			vim.cmd.colorscheme("catppuccin-latte")
		end,
	},
	tokyonight = {
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	gruvbox = {
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("gruvbox")
		end,
	},
	kanagawa = {
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("kanagawa")
		end,
	},
	["rose-pine"] = {
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("rose-pine")
		end,
	},
	everforest = {
		"neanias/everforest-nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("everforest").setup({
				background = "soft",
			})
			vim.cmd.colorscheme("everforest")
		end,
	},
	nordfox = {
		"shaunsingh/nord.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("nord")
		end,
	},
	bamboo = {
		"ribru17/bamboo.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("bamboo").setup({})
			require("bamboo").load()
		end,
	},
	matteblack = {
		"tahayvr/matteblack.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("matteblack")
		end,
	},
	["monokai-pro"] = {
		"gthelding/monokai-pro.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("monokai-pro").setup({
				filter = "ristretto",
				override = function()
					return {
						NonText = { fg = "#948a8b" },
						MiniIconsGrey = { fg = "#948a8b" },
						MiniIconsRed = { fg = "#fd6883" },
						MiniIconsBlue = { fg = "#85dacc" },
						MiniIconsGreen = { fg = "#adda78" },
						MiniIconsYellow = { fg = "#f9cc6c" },
						MiniIconsOrange = { fg = "#f38d70" },
						MiniIconsPurple = { fg = "#a8a9eb" },
						MiniIconsAzure = { fg = "#a8a9eb" },
						MiniIconsCyan = { fg = "#85dacc" },
					}
				end,
			})
			vim.cmd.colorscheme("monokai-pro")
		end,
	},
}

-- Return the appropriate theme spec based on what Omarchy selected
if colorscheme_to_load and theme_specs[colorscheme_to_load] then
	return theme_specs[colorscheme_to_load]
else
	-- Fallback to bamboo theme for osaka-jade (which doesn't use LazyVim wrapper)
	return theme_specs["catppuccin"]
end
