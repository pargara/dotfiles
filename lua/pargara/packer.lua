-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', branch = 'main',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use ({'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'}})
    use ({'ThePrimeagen/harpoon'})
    use ({'mbbill/undotree'})
    use ({'tpope/vim-fugitive'})
    use ({'williamboman/mason.nvim'})
    use ({'williamboman/mason-lspconfig.nvim'})
    use ({'github/copilot.vim'})
    use ({'nvim-lualine/lualine.nvim'})
    use ({'csexton/trailertrash.vim'})
    use ({'tpope/vim-commentary'})
    use ({'folke/todo-comments.nvim'})
    use ({'xiyaowong/transparent.nvim'})
    use ({'andweeb/presence.nvim'})
    use ({'catppuccin/nvim'})
    use ({'kdheepak/lazygit.nvim'})
    use ({'sphamba/smear-cursor.nvim'})
    use ({'MunifTanjim/nui.nvim'})
    use ({'MeanderingProgrammer/render-markdown.nvim'})
    use ({'nvim-tree/nvim-web-devicons'})
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'main',
        requires = {
            --- Uncomment these if you want to manage LSP servers from neovim
            -- {'williamboman/mason.nvim'},
            -- {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            {'neovim/nvim-lspconfig'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip', run = 'make install_jsregexp'},
        }
    }

    -- Claude Code integration
    use ({'folke/snacks.nvim'})
    use {
        'coder/claudecode.nvim',
        requires = {'folke/snacks.nvim'},
        config = function()
            require('claudecode').setup({
                auto_start = #vim.api.nvim_list_uis() > 0,
            })
        end,
    }

    use {
        'yetone/avante.nvim',
        branch = 'main',
        run = 'make',
        requires = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
            'MeanderingProgrammer/render-markdown.nvim',
            'nvim-tree/nvim-web-devicons',
            'folke/snacks.nvim',
        },
    }

end)
