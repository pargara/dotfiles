:set number
:set mouse=a
:set relativenumber
syntax on
filetype plugin indent on
filetype on
filetype indent on
filetype plugin on
:autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
:autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2
let g:deoplete#enable_at_startup = 1


call plug#begin()
Plug 'https://github.com/ap/vim-css-color' " Previsualizar colores de CSS
" Plug RuboCop
Plug 'ngmy/vim-rubocop'
" Plug para la barra de status
Plug 'nvim-lualine/lualine.nvim'
Plug 'sheerun/vim-polyglot'
" Plug para tener Ayu como theme
Plug 'ayu-theme/ayu-vim'
" Plug para soporte de ruby/rails
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
" Plug para hacer autocompletado
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug para AstoJs
Plug 'wuelnerdotexe/vim-astro'
" Plug para navegacion con telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'BurntSushi/ripgrep'
call plug#end()

set termguicolors
let ayucolor="dark"
colorscheme ayu

let g:deoplete#enable_at_startup = 1

lua << END
require('lualine').setup {
options = { theme = "ayu_dark"}
}
END


" RuboCop Stuff
let g:vimrubocop_config = '~/.config/rubocop/default.yml'
let g:vimrubocop_keymap = 0
nmap <Leader>r :RuboCop<CR>

set encoding=UTF-8

let g:astro_typescript = 'enable'

set clipboard=unnamedplus " configuracion para copiar y pegar por fuera de nvim

" Telescope Stuff
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
