""" ~/.vimrc: Runtime configuration for `vim`

" Initialize Vundle
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'chriskempson/base16-vim'
Plugin 'bling/vim-bufferline'
Plugin 'tpope/vim-commentary'
Plugin 'junegunn/vim-easy-align'
Plugin 'tpope/vim-repeat'
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

if &encoding ==? "utf-8"
  set listchars=eol:¶,tab:→·,trail:·
endif

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
set hidden
set modelines=1

" Allow bright without bold
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

set background=dark
colorscheme base16-tomorrow

let mapleader = "\<Space>"

nnoremap <CR> :
au BufReadPost quickfix nnoremap <buffer> <CR> <CR>

nnoremap <silent><BS> :nohlsearch<CR>
nnoremap Y y$
nnoremap U <C-r>

nnoremap S :bp<CR>
nnoremap s :bn<CR>
cabbrev help tab help

" Map gs to switch between source and header file
function! FileHeaderSource()
  let extension = expand('%:e')
  let name = expand('%:r')
  if extension == 'h' && filereadable(name . '.c')
    exec ':e ' . name . '.c'
    return
  endif
  if extension == 'c' && filereadable(name . '.h')
    exec ':e ' . name . '.h'
    return
  endif
endfunction
nnoremap gs :call FileHeaderSource()<CR>

" Map Q to close inactive unmodified buffers
function! CloseUnmodifiedBuffers()
  let i = 0
  while i < bufnr('$')
    let i = i + 1
    if bufloaded(i) && bufwinnr(i) < 0 && getbufvar(i, '&modified') == 0
      exec 'bd ' . i
    endif
  endwhile
endfunction
nnoremap Q :call CloseUnmodifiedBuffers()<CR>

" Configuration subsection for vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if &encoding ==? "utf-8"
  let g:airline_symbols.branch   = '⎇'
  let g:airline_symbols.linenr   = '␤'
  let g:airline_symbols.modified = '+'
  let g:airline_symbols.readonly = 'RO'
  let g:airline_left_sep         = '▶'
  let g:airline_right_sep        = '◀'
endif

set noshowmode
set laststatus=2

" Configuration subsection for tagbar
let g:tagbar_indent = 0
let g:tagbar_sort = 0
nmap <F8> :TagbarToggle<CR>

" Configuration subsection for vim-easy-align
vmap <Enter> <Plug>(EasyAlign)

au FileType python setlocal sw=4 sts=4

""" ~/.vimrc: Runtime configuration for `vim`
