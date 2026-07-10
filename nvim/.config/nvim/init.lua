-- Bootstrap lazy.nvim done in config
require("config.lazy")
-- store editor configs and general keymaps, plugin level keymaps are stored in the plugins themselves
require("config.editor-options")
-- all diagnostic logic here
require("config.diagnostics")
-- lsp activate, keymaps, and configs, default configs from nvim-lspconfig are used generally
require("config.lsp")
-- require("config.completions")
require("config.autocommands")
