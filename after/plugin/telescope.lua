-- CtrlP was dropped; the leader keys it owned in vim-misc/vimrc.vim are
-- redirected here to their Telescope equivalents.

vim.keymap.set("n", "<leader>t", "<cmd>Telescope find_files<cr>",
  { desc = "Find files" })
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>",
  { desc = "Buffers" })
vim.keymap.set("n", "<leader>l", "<cmd>Telescope current_buffer_fuzzy_find<cr>",
  { desc = "Lines in buffer" })
