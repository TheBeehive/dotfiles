""" ~/.vimrc: Runtime configuration for `vim`

" Always use UTF-8 encoding
set encoding=utf-8

if has('win32')
  set runtimepath+=~/.vim
endif

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-lion'
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

set clipboard=unnamed

set display+=lastline
set scrolloff=1
set sidescrolloff=4
set hlsearch
set incsearch
set listchars=eol:¶,tab:→·,trail:·
set number
set numberwidth=4
set ruler
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
set modelines=2

" Allow bright without bold
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif
set background=dark
silent! colorscheme base16-ocean

" Open help window splitright with width 78
autocmd FileType help set bufhidden=unload | wincmd L | vertical resize 78

let mapleader = "\<Space>"

noremap <CR> :

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

nnoremap <Leader>r :source $MYVIMRC<CR>

nnoremap <silent> [b :<C-u>exec '' . (v:count ? v:count : '') . 'bprev'<CR>
nnoremap <silent> [B :<C-u>exec '' . (v:count ? v:count : '') . 'bfirst'<CR>
nnoremap <silent> ]b :<C-u>exec '' . (v:count ? v:count : '') . 'bnext'<CR>
nnoremap <silent> ]B :<C-u>exec '' . (v:count ? v:count : '') . 'blast'<CR>

function! ToggleQuickfixList()
  redir => output
  " Find all active [Quickfix List] buffers
  silent! filter /^\[Quickfix List\]$/ ls a
  redir END
  let bufnr = matchstr(output, '\d\+')

  if !empty(bufnr) && bufwinnr(str2nr(bufnr)) != -1
    cclose
    return
  endif

  let winnr = winnr()
  copen
  if winnr() != winnr
    wincmd p
  endif
endfunction
nnoremap <silent> <Leader>q :call ToggleQuickfixList()<CR>

nnoremap <silent> [q :<C-u>exec '' . (v:count ? v:count : '') . 'cprev'<CR>zv
nnoremap <silent> [Q :<C-u>exec '' . (v:count ? v:count : '') . 'cfirst'<CR>zv
nnoremap <silent> ]q :<C-u>exec '' . (v:count ? v:count : '') . 'cnext'<CR>zv
nnoremap <silent> ]Q :<C-u>exec '' . (v:count ? v:count : '') . 'clast'<CR>zv

nnoremap <silent> [l :<C-u>exec '' . (v:count ? v:count : '') . 'lprev'<CR>zv
nnoremap <silent> [L :<C-u>exec '' . (v:count ? v:count : '') . 'lfirst'<CR>zv
nnoremap <silent> ]l :<C-u>exec '' . (v:count ? v:count : '') . 'lnext'<CR>zv
nnoremap <silent> ]L :<C-u>exec '' . (v:count ? v:count : '') . 'llast'<CR>zv

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

" Configuration subsection for vim-plug

" Set the plug window height based on the number of plugs
let g:plug_window = 'botright ' . (len(g:plugs) + 4) . 'new'

" Configuration subsection for lightline

let g:lightline = { 'colorscheme': 'Tomorrow_Night' }

set noshowmode
set laststatus=2

" Configuration subsection for vim-lion

let g:lion_squeeze_spaces = 1
let g:lion_map_left = 'c<'
let g:lion_map_right = 'c>'

" Configuration subsection for tagbar

let g:tagbar_indent = 0
let g:tagbar_sort = 0
nmap <Leader>tt :TagbarToggle<CR>

autocmd FileType python setlocal sw=4 sts=4

""" ~/.vimrc: Runtime configuration for `vim`
