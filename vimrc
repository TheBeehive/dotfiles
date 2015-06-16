""" ~/.vimrc: Runtime configuration for `vim`

" initialize Vundle
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'chriskempson/base16-vim'
Plugin 'tpope/vim-commentary'
Plugin 'junegunn/vim-easy-align'
Plugin 'tpope/vim-repeat'
Plugin 'kshenoy/vim-signature'
Plugin 'majutsushi/tagbar'

call vundle#end()

filetype plugin indent on
syntax on

set autoindent
set backspace=indent,eol,start
set expandtab
set softtabstop=2
set shiftround
set shiftwidth=2

set listchars=eol:¶,tab:→·,trail:·

set display+=lastline
set scrolloff=1
set sidescrolloff=4
set hlsearch
set incsearch
set number
set numberwidth=4
set ruler
set showcmd
set visualbell t_vb=
set wildmenu
set wildmode=longest:full
set splitright

set complete-=i
set nrformats-=octal

set history=2000
set undolevels=2000
set autoread
set modelines=1

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

" configuration subsection for vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch   = '⎇'
let g:airline_symbols.linenr   = '␤'
let g:airline_symbols.modified = '+'
let g:airline_symbols.readonly = 'RO'

let g:airline_left_sep         = '▶'
let g:airline_right_sep        = '◀'

set noshowmode
set laststatus=2

" configuration subsection for tagbar
let g:tagbar_indent = 0
nmap <F8> :TagbarToggle<CR>

" configuration subsection for vim-easy-align
vmap <Enter> <Plug>(EasyAlign)

""" ~/.vimrc: Runtime configuration for `vim`
