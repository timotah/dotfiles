# Things to still do

- [x] configuring diagnostics a bit more, maybe use virtual lines
- [x] learn about the quickfixes interface
- [x] learning oil nvim better
- [x] markdown plugin
- [x] autocomplete suggestions for the command line as well
- [x] configure some adjustments to command line autocomplete: removing type declarations in it, autocomplete keymaps
- [x] border window for the command line also
- [x] configuring dashboard a bit better for some general telescope finder options or go right to oil
- [x] choosing between ts_ls and eslint - **chose ts_ls**
- [x] simplify your lsp configuration to your own tools, can still use telescope if you want
- [x] adding lazydev to get completion on the vim global api
- [x] installing angular html css lsps and treesitter maybe some angular snippets too for control flow
- [x] installing json and yaml lsps and treesitter
- [x] change to fzf lua
- [x] adding a more custom startup window for the dashboard - not going to use one
- [x] checkout trouble.nvim
- [ ] look at treesitter incremental selection and what it is
- [x] nerdfont
- [x] prettier lualine
- [x] adding the html lsp to the htmlangular filetype
- [x] adding emmet abbreviation ability in html and angularhtml
- [x] getting the header of the functions to stick on scrolling, will help with symbol search
- [x] removing the autopairs extension

# Things that must be done before using in work

- [x] learning a bit more about tmux, and the scrolling, maybe using vim motions within it
- [x] change definition operations off of telescope to native nvim
- [x] learn to control mutliple windows in neovim at once
- [x] angularls needs to have forceStrictTemplate enabled and somehow use vim.lsp.config or the angular.ls for it, do it in the angularls file, may just have to debug at the lsp level for the configuration change
- [x] configuring codecompanion with my copilot token
- [x] configuring inline copilot token suggestions
- [x] organize completion for snippets vs lsp stuff - just know what to type for your snippets
- [x] allow for typescript to get js snippets
- [x] some sort of fuzzy finder for in the terminal to cd into things, figuring out how to use fzf for that
- [x] finding a color scheme i actually like, may go back to original for now

# Things to get for the next lsp updates

- [ ] figuring out omnifunctions to avoid constant lsp completion
- [x] making copilot into a button press for acceptance rather than a tab press
- [ ] trying vtls server instead of ts_ls, or if that doesn't work, look at alternatives
- [x] add package.json/.git/package-lock.json to the root directory detection for the ts_ls server
- [x] figure out why angularls and copilot are not considered valid names for the lsp servers with the TS* commands: no need since i just roll my own lsp configs now
- [x] glyph icons for the statuses
- [x] shortcut for all diagnostic errors, some sort of bottom error line
- [x] remove the virtual_lines, it is agressive

## Nice to haves for the next updates
- [ ] possibly try otter.nvim
- [ ] add harpoon
- [x] hook up the ts_ls server and look for certain optimizations, put completions to a keybinding
- [x] setting up conform.nvim
- [x] putting proper icons
- [x] adding auto tag complete
- [x] git signs
- [x] checkout snacks scope
- [x] sticky headers
- [x] check out snacks git
- [x] gitsigns 
- [x] fugitive
- [ ] learning more about gitsigns abilities and fugitive abilities, maybe making keybindings for them?
- [ ] fix the reference commands GR
- [ ] checkout fff.nvim
- [ ] learn more about quickfix lists
