-- Neovim 0.12+ config built on mitchellh/vim-misc.
-- Uses native vim.pack for plugins, native vim.lsp.config/enable for LSP,
-- and the new nvim-treesitter main-branch API. Per-plugin setup lives in
-- after/plugin/.

vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

vim.g.vim_home_path = vim.fn.stdpath("config")

for _, dir in ipairs({ "swap", "backup", "undo" }) do
  vim.fn.mkdir(vim.g.vim_home_path .. "/" .. dir, "p")
end

vim.pack.add({
  { src = "https://github.com/mitchellh/vim-misc" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/numToStr/Comment.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
})

local vim_misc_rc = vim.fn.stdpath("data") .. "/site/pack/core/opt/vim-misc/vimrc.vim"
if vim.fn.filereadable(vim_misc_rc) == 1 then
  vim.cmd.source(vim_misc_rc)
end
