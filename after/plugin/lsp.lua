-- Personal LSP setups, layered on top of mitchellh/vim-misc's gopls.
-- vim-misc.lua already defined `on_attach` and called lspconfig for gopls;
-- we re-use the same legacy API here. Add a server by:
--   1) installing its binary (brew/npm/go install/etc.)
--   2) uncommenting / adding a setup{} block below.

local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then return end

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K',  vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<space>f',  function() vim.lsp.buf.format({ async = true }) end, opts)
end

-- Examples — uncomment what you need after installing the binary.

-- TypeScript / JavaScript:  npm i -g typescript typescript-language-server
-- lspconfig.ts_ls.setup { on_attach = on_attach }

-- Python:                   pip install pyright   (or: brew install pyright)
-- lspconfig.pyright.setup { on_attach = on_attach }

-- Lua:                      brew install lua-language-server
-- lspconfig.lua_ls.setup { on_attach = on_attach }

-- Rust:                     rustup component add rust-analyzer
-- lspconfig.rust_analyzer.setup { on_attach = on_attach }

-- Bash:                     npm i -g bash-language-server
-- lspconfig.bashls.setup { on_attach = on_attach }

-- Ruby:                     gem install ruby-lsp  (treasury also has it in Gemfile)
-- ruby-lsp auto-loads the ruby-lsp-rails addon when present in the Gemfile.
lspconfig.ruby_lsp.setup {
  on_attach = on_attach,
  init_options = {
    formatter = 'auto',
    linters = { 'rubocop' },
  },
}
