-- Shadow stub for mitchellh/vim-misc's lua/vim-misc.lua.
-- The plugin's vimrc.vim ends with `lua require("vim-misc")` to load LSP,
-- treesitter, and Comment.nvim setup using APIs that are removed in
-- Neovim 0.11+ (vim.lsp.diagnostic.*, nvim-treesitter.configs, the
-- legacy require('lspconfig') framework). Our config dir comes first on
-- runtimepath so this file wins package resolution and the broken setup
-- is replaced by modern equivalents in after/plugin/.

vim.opt.laststatus = 3

return {}
