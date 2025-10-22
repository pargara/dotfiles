vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>tb", vim.cmd.tabedit)
vim.keymap.set("n", "<leader>tt", vim.cmd.TrailerTrim)
vim.keymap.set("n", "<leader>trs", vim.cmd.TransparentToggle)
vim.keymap.set("n", "<leader>lg", vim.cmd.LazyGit)
vim.keymap.set("n", "<leader>lgc", vim.cmd.LazyGitCurrentFile)
vim.keymap.set('n', '<leader>cp', ':let @+ = expand("%")<CR>', { silent = true })
