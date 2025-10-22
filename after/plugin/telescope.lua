local telescope = require('telescope')
local builtin = require('telescope.builtin')

-- Setup telescope with fzf-native for faster and smarter fuzzy finding
telescope.setup({
    defaults = {
        -- Better fuzzy matching that works with tokens
        path_display = { 'smart' },
        file_ignore_patterns = { "node_modules", ".git/" },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },
        -- Use FZF sorter for better token-based matching
        file_sorter = require('telescope.sorters').get_fzf_sorter,
        generic_sorter = require('telescope.sorters').get_fzf_sorter,
    },
    pickers = {
        find_files = {
            -- Enable smart case and better fuzzy finding
            find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- Enable fuzzy matching
            override_generic_sorter = true,  -- Override the generic sorter
            override_file_sorter = true,     -- Override the file sorter
            case_mode = 'smart_case',        -- Smart case matching
        },
    },
})

-- Load fzf native extension for much faster and better fuzzy finding
-- This enables tokenized searches like "client banco plaza" -> "banco_plaza_client.rb"
pcall(telescope.load_extension, 'fzf')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ")});
end)

