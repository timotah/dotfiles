return {
	"NickvanDyke/opencode.nvim",
	dependencies = {
		-- Recommended for `ask()` and `select()`.
		-- Required for `snacks` provider.
		---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
		{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
	},
	config = function()
		---@type opencode.Opts
		vim.g.opencode_opts = {
			provider = {
				enabled = "snacks",
				snacks = {
					auto_close = true,
					win = {
						enter = false,
					},
				},
			},
			ask = {
				snacks = {
					win = {
						relative = "cursor",
						row = 1,
						col = 0,
					},
				},
			},
		}

		-- Required for `opts.events.reload`.
		vim.o.autoread = true

		local opencode_terminal_filetype = "opencode_terminal"

		local function toggle_opencode_terminal()
			local current_win = vim.api.nvim_get_current_win()
			local current_buf = vim.api.nvim_get_current_buf()
			local current_ft = vim.bo[current_buf].filetype

			if current_ft == opencode_terminal_filetype then
				vim.cmd("wincmd p")
			else
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					if vim.bo[buf].filetype == opencode_terminal_filetype then
						vim.api.nvim_set_current_win(win)
						return
					end
				end
				require("opencode").toggle()
			end
		end

		-- Auto-close opencode terminal when quitting Neovim
		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				local snacks = require("snacks")
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					if vim.bo[buf].filetype == opencode_terminal_filetype then
						snacks.win.close(win)
					end
				end
			end,
		})

		-- Keymaps
		vim.keymap.set("n", "<leader>ao", function()
			require("opencode").toggle()
		end, { desc = "Toggle opencode" })
		vim.keymap.set({ "n", "t" }, "<C-a>", toggle_opencode_terminal, { desc = "Toggle opencode terminal focus" })
		vim.keymap.set("n", "<C-p>", function()
			require("opencode").ask("", { submit = true })
		end, { desc = "Ask opencode…" })
		vim.keymap.set("x", "<C-p>", function()
			require("opencode").ask("@this: ", { submit = true })
		end, { desc = "Ask opencode with selection" })
		vim.keymap.set("n", "<M-u>", function()
			require("opencode").command("session.half.page.up")
		end, { desc = "Scroll opencode up" })
		vim.keymap.set("n", "<M-d>", function()
			require("opencode").command("session.half.page.down")
		end, { desc = "Scroll opencode down" })
	end,
}
