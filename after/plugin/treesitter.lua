-- nvim-treesitter on the main branch (v1.0+). The plugin only ships
-- parsers and queries now; we install parsers and turn on highlighting
-- ourselves via vim.treesitter.start.

local ok, ts = pcall(require, "nvim-treesitter")
if not ok then return end

local parsers = {
  "lua", "vim", "vimdoc", "query",
  "ruby", "go",
  "javascript", "typescript", "tsx",
  "bash", "json", "yaml",
  "markdown", "markdown_inline",
}

pcall(ts.install, parsers)

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable treesitter highlighting when a parser is installed",
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
