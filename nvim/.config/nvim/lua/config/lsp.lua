local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", {
	capabilities = capabilities,
})
vim.lsp.enable({
	-- lua
	"lua_ls",
	-- js/ts
	"ts_ls",
	-- angularls
	"angularls",
	-- html
	"html",
	-- css
	"cssls",
	-- python
	"pyright",
	-- emmet
	-- "emmet_language_server",
  -- copilot
  "copilot",
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "Lsp: " .. desc })
		end

		-- local tele = require("telescope.builtin")
		-- map("gd", vim.lsp.buf.definition, "Goto Definition")
		-- map("gr", tele.lsp_references, 'Goto References')
		-- map("<leader>fs", tele.lsp_document_symbols, "Doc Symbols")
		-- map("<leader>fS", tele.lsp_dynamic_workspace_symbols, "Dynamic Symbols")
		-- map("<leader>ft", tele.lsp_type_definitions, "Goto Type")
		-- map("<leader>fi", tele.lsp_implementations, "Goto Impl")

		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("<leader>E", vim.diagnostic.open_float, "Diagnostic Info")
		map("<leader>k", vim.lsp.buf.signature_help, "Signature Help")
		map("<leader>rn", vim.lsp.buf.rename, "Rename")
		map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
	end,
})

-- adding hover borders for lsps, not doing it right now because of telescope weird borders
-- vim.o.winborder = "rounded"

-- PERFORMANCE TIP: To disable diagnostics or formatting for TypeScript, add to your ts_ls config:
-- vim.lsp.config("ts_ls", { settings = { diagnostics = { enable = false }, format = { enable = false } } })
-- To increase node memory for tsserver, set the env variable before launching Neovim:
-- export NODE_OPTIONS=--max-old-space-size=4096
