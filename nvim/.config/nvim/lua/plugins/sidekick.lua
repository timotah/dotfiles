return {
	"folke/sidekick.nvim",
	opts = {
		-- add any options here
    nes = {
      enabled = false,
    },
		cli = {
			mux = {
				backend = "tmux",
				enabled = true,
			},
			win = {
				keys = {
					prompt = { "<a-p>", "prompt", mode = "t", desc = "insert prompt or context" },
				shift_enter = {
					"<S-CR>",
					function(terminal)
						vim.api.nvim_chan_send(terminal.job, "\x1b[13;2u")
					end,
					mode = "t",
					desc = "Send Shift+Enter to terminal application",
				},
					toggle_focus = {
						"<c-a>",
						function(terminal)
							local mode = vim.fn.mode()

							if mode == "t" then
								-- We're in terminal mode, need to switch to another window
								-- Note: wincmd("p") doesn't work from terminal mode keymaps,
								-- so we manually find and switch to a non-terminal window

								local current_win = vim.api.nvim_get_current_win()
								local all_wins = vim.api.nvim_list_wins()

								-- Find the first window that isn't the current terminal
								local target_win = nil
								for _, win in ipairs(all_wins) do
									if win ~= current_win then
										target_win = win
										break
									end
								end

								if target_win then
									-- Exit terminal mode first
									vim.cmd.stopinsert()

									-- Schedule the window switch to happen after stopinsert completes
									vim.schedule(function()
										vim.api.nvim_set_current_win(target_win)
									end)
								end
							else
								-- Already in normal mode, use the standard blur method
								terminal:blur()
							end
						end,
						mode = { "n", "t" },
						desc = "Return to editor",
					},
				},
			},
			tools = {
				opencode = {
					cmd = { "opencode" },
					-- HACK: https://github.com/sst/opencode/issues/445
					-- env = { OPENCODE_THEME = "catppuccin" },
					env = {
						OPENCODE_CONFIG_DIR = vim.fn.expand("~/.config/opencode/"),
					},
				},
				["kiro-cli"] = {
					cmd = { "kiro-cli" },
				},
			},
		},
	},
	keys = {
		{
			"<tab>",
			function()
				-- if there is a next edit, jump to it, otherwise apply it if any
				if not require("sidekick").nes_jump_or_apply() then
					return "<Tab>" -- fallback to normal tab
				end
			end,
			expr = true,
			desc = "Goto/Apply Next Edit Suggestion",
		},
		{
			"<c-a>",
			function()
				-- This keymap is for focusing the terminal from editor buffers
				-- The reverse (terminal -> editor) is handled by sidekick's win.keys
				require("sidekick.cli").focus()
			end,
			desc = "Sidekick Focus Terminal",
			mode = { "n", "i", "x" }, -- Removed "t" mode since it's handled by sidekick
		},
		{
			"<leader>ao",
			function()
				require("sidekick.cli").toggle({ name = "opencode", focus = true })
			end,
			desc = "Sidekick Toggle Opencode",
		},
		{
			"<leader>aa",
			function()
				require("sidekick.cli").toggle()
			end,
			desc = "Sidekick Toggle CLI",
		},
		{
			"<leader>as",
			function()
				require("sidekick.cli").select()
			end,
			-- Or to select only installed tools:
			-- require("sidekick.cli").select({ filter = { installed = true } })
			desc = "Select CLI",
		},
		{
			"<leader>ad",
			function()
				require("sidekick.cli").close()
			end,
			desc = "Detach a CLI Session",
		},
		{
			"<a-h>",
			function()
				require("sidekick.cli").hide()
			end,
			desc = "Hide a CLI Session",
			mode = { "t" },
		},
		{
			"<leader>ah",
			function()
				require("sidekick.cli").hide()
			end,
			desc = "Hide a CLI Session",
		},
		{
			"<leader>at",
			function()
				require("sidekick.cli").send({ msg = "{this}" })
			end,
			mode = { "x", "n" },
			desc = "Send This",
		},
		{
			"<leader>af",
			function()
				require("sidekick.cli").send({ msg = "{file}" })
			end,
			desc = "Send File",
		},
		{
			"<leader>av",
			function()
				require("sidekick.cli").send({ msg = "{selection}" })
			end,
			mode = { "x" },
			desc = "Send Visual Selection",
		},
		{
			"<leader>ap",
			function()
				require("sidekick.cli").prompt()
			end,
			mode = { "n", "x" },
			desc = "Sidekick Select Prompt",
		},
	},
}
