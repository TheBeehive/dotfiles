" initialize Vundle
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

Plugin 'chriskempson/base16-vim'
Plugin 'bling/vim-airline'
Plugin 'junegunn/vim-easy-align'

call vundle#end()
filetype plugin on

" enable syntax highlighting
syntax on

set autoindent
set backspace=indent,eol,start
set expandtab
set shiftwidth=2
set softtabstop=2

set laststatus=2
set number
set showcmd
set noshowmode
set wildmenu
set wildmode=longest:full

set display+=lastline
set hlsearch
set incsearch
set scrolloff=1
set sidescrolloff=5

set splitright
set splitbelow

set autoread
set history=2000
set mouse=

" allow bright without bold
if &t_Co == 0 && $TERM !~# '^linux'
  set t_Co=256
endif
set background=dark
colorscheme base16-tomorrow

let mapleader = "\<Space>"
nnoremap <silent> <Leader>c :nohlsearch<CR>
nnoremap U :redo<CR>
nnoremap gp :bp<CR>
nnoremap gn :bn<CR>
cabbrev help vert bo help

" configuration for vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" configuration for vim-easy-align
vmap <Enter> <Plug>(EasyAlign)
