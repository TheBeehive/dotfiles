""" ~/.vimrc: Runtime configuration for `vim`

if has('win32')
  set runtimepath+=~/.vim
endif

call plug#begin('~/.vim/plugged')

Plug 'bling/vim-airline'
Plug 'chriskempson/base16-vim'
Plug 'bling/vim-bufferline'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'majutsushi/tagbar'
Plug 'raimondi/delimitmate'

call plug#end()

set nocompatible
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

set clipboard=unnamed

set display+=lastline
set scrolloff=1
set sidescrolloff=4
set hlsearch
set incsearch
set number
set numberwidth=4
set ruler
set visualbell t_vb=
set wildmenu
set wildmode=longest:full
set splitright

set complete-=i
set nrformats-=octal
set tildeop

set history=2000
set undolevels=2000
set autoread
set hidden
set modelines=2

" Allow bright without bold
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

set background=dark
silent! colorscheme base16-tomorrow
" Only supported in MacVim
if has("gui_macvim")
  set transparency=10
endif
hi Search ctermfg=10 guifg=#282a2e

let mapleader = "\<Space>"

noremap <CR> :
au BufReadPost quickfix nnoremap <buffer> <CR> <CR>

nnoremap <silent><BS> :nohlsearch<CR>
nnoremap Y y$
nnoremap U <C-r>
noremap Q @

cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Map window motions to g prefixed lowercased ones
noremap gh H
noremap gl L
noremap gm M

" H and L are easier than ^ and $
noremap <expr> H (v:count == 0 ? '^' : '|')
noremap gH g^
noremap L $
noremap gL g$

" Map M to ' (' is the opposite of m)
noremap M '

nnoremap <C-h> :bp<CR>
nnoremap <C-l> :bn<CR>
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

" Map s to window navigation prefix
noremap s <C-w>
noremap S <NOP>

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
nnoremap <silent> gs :call FileHeaderSource()<CR>

" Map 0 to close inactive unmodified buffers
function! CloseUnmodifiedBuffers()
  let i = 0
  while i < bufnr('$')
    let i = i + 1
    if bufloaded(i) && bufwinnr(i) < 0 && getbufvar(i, '&modified') == 0
      exec 'bd ' . i
    endif
  endwhile
endfunction
nnoremap <silent> 0 :call CloseUnmodifiedBuffers()<CR>

" Add visual mode diffget/put and do diffupdate after do/dp
nnoremap do do:diffupdate<CR>
nnoremap dp dp:diffupdate<CR>
xnoremap do :diffget<CR>|:diffupdate<CR>
xnoremap dp :diffput<CR>|:diffupdate<CR>
nnoremap du :diffupdate<CR>

" Configuration subsection for vim-plug

" Set the plug window height based on the number of plugs
let g:plug_window = 'botright ' . (len(g:plugs) + 4) . 'new'

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

" Configuration subsection for vim-bufferline

let g:bufferline_echo = 0

" Configuration subsection for tagbar

let g:tagbar_indent = 0
let g:tagbar_sort = 0
nmap <F8> :TagbarToggle<CR>

" Configuration subsection for vim-easy-align

"vmap <Enter> <Plug>(EasyAlign)

au FileType python setlocal sw=4 sts=4

""" ~/.vimrc: Runtime configuration for `vim`
