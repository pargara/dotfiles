" mitchellh/vim-misc loader for Neovim
" The vim-misc vimrc reads g:vim_home_path; point it at this config dir.
let g:vim_home_path = stdpath('config')

" Bootstrap vim-plug on first run.
let s:plug_path = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(s:plug_path))
  silent execute '!curl -fLo ' . s:plug_path
        \ . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(g:vim_home_path . '/plugged')
Plug 'mitchellh/vim-misc'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neovim/nvim-lspconfig', { 'tag': 'v2.5.0' }
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'master', 'do': ':TSUpdate' }
Plug 'numToStr/Comment.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()

" Source mitchellh/vim-misc's vimrc once it's been installed by :PlugInstall.
let s:vim_misc_rc = g:vim_home_path . '/plugged/vim-misc/vimrc.vim'
if filereadable(s:vim_misc_rc)
  execute 'source ' . s:vim_misc_rc
endif
