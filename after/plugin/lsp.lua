-- LSP via Neovim 0.11+ native API. nvim-lspconfig ships per-server
-- defaults under its lsp/ directory; vim.lsp.enable picks them up.
-- Per-server overrides go through vim.lsp.config(name, { ... }).

vim.lsp.config("ruby_lsp", {
  init_options = {
    formatter = "auto",
    linters = { "rubocop" },
  },
})

vim.lsp.enable({ "ruby_lsp", "gopls" })

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = { border = "rounded" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN]  = "W",
      [vim.diagnostic.severity.HINT]  = "H",
      [vim.diagnostic.severity.INFO]  = "I",
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Buffer-local LSP keymaps",
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }

    vim.keymap.set("n", "gD",        vim.lsp.buf.declaration,        opts)
    vim.keymap.set("n", "gd",        vim.lsp.buf.definition,         opts)
    vim.keymap.set("n", "K",         vim.lsp.buf.hover,              opts)
    vim.keymap.set("n", "gi",        vim.lsp.buf.implementation,     opts)
    vim.keymap.set("n", "gs",        vim.lsp.buf.signature_help,     opts)
    vim.keymap.set("n", "gr",        vim.lsp.buf.references,         opts)
    vim.keymap.set("n", "<space>D",  vim.lsp.buf.type_definition,    opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename,             opts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action,        opts)
    vim.keymap.set("n", "<space>e",  vim.diagnostic.open_float,      opts)
    vim.keymap.set("n", "[d",        function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
    vim.keymap.set("n", "]d",        function() vim.diagnostic.jump({ count =  1, float = true }) end, opts)
    vim.keymap.set("n", "<space>q",  vim.diagnostic.setloclist,      opts)
    vim.keymap.set("n", "<space>f",  function() vim.lsp.buf.format({ async = true }) end, opts)
  end,
})
