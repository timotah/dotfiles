return {
	cmd = {
		"node",
		vim.fn.stdpath("data") .. "/lazy/copilot.vim/copilot-language-server/dist/language-server.js",
		"--stdio",
	},
	filetypes = { "*" },
	single_file_support = true,
	root_dir = function()
		return vim.fn.getcwd()
	end,
}
