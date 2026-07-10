-- set initial neovim configs such as tab/spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.cmd.colorscheme "catppuccin-mocha"
vim.opt.termguicolors = true
-- any commands that you want to have a short to, add <leader>
vim.g.mapleader = " "

-- line numbers
vim.opt.relativenumber = true
-- Enable absolute line numbers -- changes 0 on the current line to the actual line number
vim.opt.number = true
vim.opt.cursorline = true
vim.o.autoread = true


-- SET KEYMAPS HERE

vim.keymap.set("n", "<C-e>", "<cmd>Oil<CR>")
-- ensures ctrl c works like esc in insert mode
vim.keymap.set({ "i", "v" }, "<C-c>", "<Esc>")
-- allow for copying to sys clipboard
vim.keymap.set("v", "<leader>y", '"+y')

-- conform keymaps
vim.keymap.set("n", "<leader>cf", function()
  require("conform").format({async = true})
end, {desc = "Format File"})

vim.keymap.set("v", "<leader>cf", function()
  require("conform").format({ async = true }, function(err)
    if not err then
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(string.lower(mode), "v") then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
      end
    end
  end)
end, { desc = "Format code" })

-- copilot keymap redo
vim.keymap.set('i', '<C-J>', 'copilot#Accept(\"\\<CR>\")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
