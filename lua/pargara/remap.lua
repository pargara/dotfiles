vim.g.mapleader = " "

-- Use system clipboard for yank/paste
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>tb", vim.cmd.tabedit)
vim.keymap.set("n", "<leader>tt", vim.cmd.TrailerTrim)
vim.keymap.set("n", "<leader>trs", vim.cmd.TransparentToggle)
vim.keymap.set("n", "<leader>lg", vim.cmd.LazyGit)
vim.keymap.set("n", "<leader>lgc", vim.cmd.LazyGitCurrentFile)
vim.keymap.set('n', '<leader>cp', ':let @+ = expand("%")<CR>', { silent = true })

-- Claude Code keymaps
vim.keymap.set("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
vim.keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send to Claude" })
