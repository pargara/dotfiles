:set number
:set mouse=a
:set relativenumber
syntax on
filetype plugin indent on
filetype on
filetype indent on
:autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
:autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2
let g:deoplete#enable_at_startup = 1


call plug#begin()
Plug 'https://github.com/ap/vim-css-color' " Previsualizar colores de CSS
" Plug para la barra de status
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
" Plug para
Plug 'https://github.com/preservim/nerdtree'
" Plug para tener rubocop
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug para tener soporte de multiples lenguajes
Plug 'sheerun/vim-polyglot'
" Plug para tener Ayu como theme
Plug 'ayu-theme/ayu-vim'
" Plug para hacer algo como un ctrl p en vim
Plug 'liuchengxu/vim-clap'
" Plug para soporte de ruby/rails
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
" Plug para hacer autocompletado
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug para AstoJs
Plug 'wuelnerdotexe/vim-astro'
call plug#end()

set termguicolors
let ayucolor="dark"
colorscheme ayu

lua << END
require("lualine").setup {
options = { theme = "ayu_dark"}
}
END

set encoding=UTF-8

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

let g:astro_typescript = 'enable'

inoremap <expr> <TAB> pumvisible() ? "<C-y>" : "<TAB>"


set clipboard=unnamedplus " configuracion para copiar y pegar por fuera de nvim


