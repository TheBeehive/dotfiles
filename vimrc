""" ~/.vimrc: Runtime configuration for `vim`

"" Encoding and runtimepath

if has('win32')
  set encoding=utf-8 runtimepath^=~/.vim
endif

"" Plugin Configuration

call plug#begin('~/.vim/bundle')
Plug 'chriskempson/base16-vim'
Plug 'deris/vim-shot-f'
Plug 'farmergreg/vim-lastplace'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ktchen14/cscope-auto'
Plug 'ktchen14/status-symbol'
Plug 'ktchen14/vim-star'
Plug 'majutsushi/tagbar'
Plug 'neovim/nvim-lspconfig'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

endif

let polyglot_disabled = ['autoindent', 'markdown', 'sensible']
call plug#end()

"" General Configuration

" Global options
set nocompatible
filetype plugin indent on
syntax enable

" Indentation options
set autoindent
set backspace=indent,eol,start
set expandtab
set shiftround
set shiftwidth=2
set smarttab
set softtabstop=2

" Display options
set display=lastline
set laststatus=2
set listchars=eol:¶,tab:→·,nbsp:·,trail:·,extends:›,precedes:‹
set noshowmode
set number
set numberwidth=4
set scrolloff=1
set sidescrolloff=4
set splitbelow
set splitright
set visualbell t_vb=

" Behavior options
set autoread
let &clipboard = has('unnamedplus') ? 'unnamedplus' : 'unnamed'
set complete-=i
set hidden
set history=2000
set modelines=2
set nojoinspaces
set nrformats-=octal
set undolevels=2000
set wildmenu
set wildmode=longest:full

" Search options
" Keep hlsearch status on reload
let hlsearch = v:hlsearch
set hlsearch
let v:hlsearch = hlsearch
set incsearch

" Text wrap options
set breakindent
set breakindentopt=shift:-2
set formatoptions=crqnj
set showbreak=↪\ 

" Folding options
set foldopen-=block

" Color scheme options
if has('termguicolors')
  set termguicolors
endif
set background=dark
silent! colorscheme base16-ocean
silent! hi link FloatBorder NormalFloat

" Neovim
if has('nvim') | source ~/.vim/nvim.lua | end

"" Helper Functions

command! -complete=mapping -nargs=*
      \ Nxonoremap nnoremap <args>|xnoremap <args>|onoremap <args>

function! CnoreabbrevHead(from, to) abort
  exec 'cnoreabbrev <expr> ' . a:from . ' '
        \ 'getcmdtype() . getcmdline() ==# ":' . a:from . '" ? '
        \ '"' . a:to . '" : "' . a:from . '"'
endfunction

"" Mappings and Abbreviations
let mapleader = "\<Space>"

nnoremap <BS> <Cmd>nohlsearch<CR>
nnoremap Y y$
nnoremap U <C-r>

nnoremap Q @
xnoremap Q @

if exists(':tnoremap')
  tnoremap <Esc> <C-\><C-n>
endif

cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Map window motions to g prefixed lowercased ones
Nxonoremap gh H
Nxonoremap gl L
Nxonoremap gm M

" H and L are easier than ^ and $
function! Handle_h0()
  let [_, _, i, _] = getpos('.')
  if i < 2
    return "0"
  end
  return getline('.')[:i - 2] =~ '^\s*$' ? '0' : '^'
endfunction
Nxonoremap <expr> H (v:count == 0 ? Handle_h0() : '|')
Nxonoremap gH g^
Nxonoremap L $
Nxonoremap gL g$

" Map M to ' (' is the opposite of m)
Nxonoremap M '

nnoremap <C-h> <Cmd>bp<CR>
nnoremap <C-l> <Cmd>bn<CR>

" Page Up and Page Down
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

" Map s to window navigation prefix
nnoremap s <C-w>
nnoremap S <NOP>

nnoremap <Tab> za

nnoremap <Leader>rr <Cmd>source $MYVIMRC<CR>
nnoremap <Leader>re <Cmd>edit $MYVIMRC<CR>

nnoremap ]] ][
nnoremap ][ ]]

nnoremap [b <Cmd>exec '' . (v:count ? v:count : '') . 'bprev'<CR>
nnoremap [B <Cmd>exec '' . (v:count ? v:count : '') . 'bfirst'<CR>
nnoremap ]b <Cmd>exec '' . (v:count ? v:count : '') . 'bnext'<CR>
nnoremap ]B <Cmd>exec '' . (v:count ? v:count : '') . 'blast'<CR>


call CnoreabbrevHead('lgrep', 'silent lgrep')
call CnoreabbrevHead('lgr', 'silent lgrep')
call CnoreabbrevHead('grep', 'silent grep')
call CnoreabbrevHead('gr', 'silent grep')
call CnoreabbrevHead('lgrepadd', 'silent lgrepadd')
call CnoreabbrevHead('lgrepa', 'silent lgrepadd')
call CnoreabbrevHead('grepadd', 'silent grepadd')
call CnoreabbrevHead('grepa', 'silent grepadd')

"" Quickfix List

if executable('ag')
  " When ag --vimgrep is used as the grepprg and :grep is issued without
  " arguments, ag outputs 'ERR: What do you want to search for?', breaking the
  " display until a :redraw! is issued. The --silent helps avoid this.
  set grepprg=ag\ --vimgrep\ --silent\ $* grepformat=%f:%l:%c:%m
endif

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
  botright copen
  if winnr() != winnr
    wincmd p
  endif
endfunction
nnoremap <Leader>q <Cmd>call ToggleQuickfixList()<CR>

augroup vimrc
  autocmd!
  autocmd BufReadPost quickfix setlocal modifiable
        \ | silent exec '%s/|\(\d\+\) col \(\d\+\)|/|\1:\2|/Ige'
        \ | setlocal nomodifiable
  autocmd FileType quickfix setlocal nobuflisted
augroup end

nnoremap [q <Cmd>exec '' . (v:count ? v:count : '') . 'cprev'<CR>zv
nnoremap [Q <Cmd>exec '' . (v:count ? v:count : '') . 'cfirst'<CR>zv
nnoremap ]q <Cmd>exec '' . (v:count ? v:count : '') . 'cnext'<CR>zv
nnoremap ]Q <Cmd>exec '' . (v:count ? v:count : '') . 'clast'<CR>zv

nnoremap [l <Cmd>exec '' . (v:count ? v:count : '') . 'lprev'<CR>zv
nnoremap [L <Cmd>exec '' . (v:count ? v:count : '') . 'lfirst'<CR>zv
nnoremap ]l <Cmd>exec '' . (v:count ? v:count : '') . 'lnext'<CR>zv
nnoremap ]L <Cmd>exec '' . (v:count ? v:count : '') . 'llast'<CR>zv

"" Diagnostics

nnoremap <Leader>e <Cmd>lua vim.diagnostic.open_float()<CR>

nnoremap [d <Cmd>lua vim.diagnostic.goto_prev{
      \ wrap = vim.api.nvim_get_option_value('wrapscan', { scope = 'local' }),
      \ }<CR>
xnoremap [d <Cmd>lua vim.diagnostic.goto_prev{
      \ wrap = vim.api.nvim_get_option_value('wrapscan', { scope = 'local' }),
      \ float = false }<CR>
onoremap [d <Cmd>lua vim.diagnostic.goto_prev{
      \ wrap = vim.api.nvim_get_option_value('wrapscan', { scope = 'local' }),
      \ float = false }<CR>

nnoremap ]d <Cmd>lua vim.diagnostic.goto_next{
      \ wrap = vim.api.nvim_get_option_value('wrapscan', { scope = 'local' }),
      \ }<CR>
xnoremap ]d <Cmd>lua vim.diagnostic.goto_next{
      \ wrap = vim.api.nvim_get_option_value('wrapscan', { scope = 'local' }),
      \ float = false }<CR>
onoremap ]d <Cmd>lua vim.diagnostic.goto_next{
      \ wrap = vim.api.nvim_get_option_value('wrapscan', { scope = 'local' }),
      \ float = false }<CR>

"" Language Server Protocol

if exists('##LspAttach') && exists('##LspDetach')
  function! OnLspAttach()
    nnoremap <buffer> gd         <Cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <buffer> gD         <Cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <buffer> gr         <Cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <buffer> <Leader>D  <Cmd>lua vim.lsp.buf.type_definition()<CR>

    nnoremap <buffer> K          <Cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <buffer> <C-k>      <Cmd>lua vim.lsp.buf.signature_help()<CR>

    nnoremap <buffer> <Leader>rn <Cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <buffer> <Leader>ca <Cmd>lua vim.lsp.buf.code_action()<CR>
  endfunction

  function! OnLspDetach()
    nunmap <buffer> gd
    nunmap <buffer> gD
    nunmap <buffer> gr
    nunmap <buffer> <Leader>D

    nunmap <buffer> K
    nunmap <buffer> <C-k>

    nunmap <buffer> <Leader>rn
    nunmap <buffer> <Leader>ca
  endfunction

  augroup LSP
    autocmd!
    autocmd LspAttach * call OnLspAttach()
    autocmd LspDetach * call OnLspDetach()
  augroup end
end

"" Filetype Configuration

if executable('jq')
  autocmd FileType json setlocal formatprg=jq\ .
endif

autocmd FileType python setlocal sw=4 sts=4 tw=79

" Open help window splitright with width 78
autocmd FileType help set bufhidden=unload | wincmd L | vertical resize 78

"" Plugin Configuration

" vim-plug

" Set the plug window height based on the number of plugs
let g:plug_window = 'botright ' . (len(g:plugs) + 4) . 'new'

" cscope-auto

if has('cscope')
  let g:cscope_auto_database_name = '.cscope'
endif

" fzf

autocmd FileType fzf silent! tunmap <Esc>
nnoremap <C-P> <Cmd>FZF!<CR>

" vim-markdown

let g:markdown_fenced_languages = ['bash=sh', 'python']

" tagbar

let g:tagbar_indent = 0
let g:tagbar_sort = 0
nmap <Leader>tt :TagbarToggle<CR>

"" Test Area

" Use this area to test changes to this file

"" Folding Expression and Text

" Ensure that VimrcFoldExpr is callable from this modeline
if exists('&modelineexpr') | set modelineexpr | endif

function! VimrcFoldExpr()
  " Don't fold the header even though it starts with """
  if v:lnum == 1 | return 0 | end

  " Get the line without leading and trailing whitespace
  let line = matchstr(getline(v:lnum), '^\s*\zs.\{-}\ze\s*$')

  if empty(line) | return -1 | endif

  " Get the number of leading " characters
  let length = len(matchstr(line, '^"\{2,}'))
  return length > 1 ? '>1' : '='
endfunction

function! VimrcFoldText()
  let name = matchstr(getline(v:foldstart), '^\s*"*\s*\zs.\{-}\ze\s*$')
  return '+' . v:folddashes . ' ' . name . ' '
endfunction

" vim: set fdm=expr fde=VimrcFoldExpr() fdt=VimrcFoldText():
