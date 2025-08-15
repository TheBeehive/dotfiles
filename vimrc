""" ~/.vimrc: Runtime configuration for `vim`

if has('win32')
  set encoding=utf-8 runtimepath^=~/.vim
endif

call plug#begin('~/.vim/bundle')
Plug 'catppuccin/nvim', { 'as': 'catppuccin-nvim' }
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'farmergreg/vim-lastplace'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'ktchen14/colonize'
Plug 'ktchen14/cscope-auto'
Plug 'ktchen14/status-symbol'
Plug 'ktchen14/vim-star'
Plug 'llvm/llvm.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'sheerun/vim-polyglot'
Plug 'stevearc/aerial.nvim'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/syntaxm4.vim'

if mapcheck('gcc', 'n') == ''
  Plug 'tpope/vim-commentary'
endif

let polyglot_disabled = ['autoindent', 'markdown', 'sensible']
call plug#end()

"" General Configuration

" Important / Global
if &compatible
  set nocompatible
endif
filetype plugin indent on
syntax enable

" Color scheme
if has('nvim')
  silent! colorscheme catppuccin-mocha
else
  silent! colorscheme catppuccin_mocha
endif

" Behavior
set autoread
if has('unnamedplus')
  set clipboard+=unnamedplus
endif
set complete-=u complete-=i
set foldopen-=block
set hidden
set history=2000
set nojoinspaces
set nrformats-=octal
set undolevels=2000
set wildmenu
set wildmode=longest:full

" Indentation
set autoindent
set backspace=indent,eol,start
set cinoptions=Ls,l1
set expandtab
set shiftround
set shiftwidth=2
set smarttab
set softtabstop=2

" Search
if executable('ag')
  set grepprg=ag\ --vimgrep\ --silent\ $* grepformat=%f:%l:%c:%m
endif
if !&hlsearch
  set hlsearch
endif
set incsearch

" Visual
set display=lastline
set laststatus=2
set listchars=eol:¶,tab:→·,trail:·,extends:›,precedes:‹,nbsp:·
set noshowmode
set number
set scrolloff=1
set sidescrolloff=4
set splitbelow
set splitright
if has('termguicolors')
  set termguicolors
endif
set visualbell t_vb=

" Text wrap
set breakindent
set breakindentopt=shift:-2
set fo-=t fo+=r fo+=n fo+=j
set showbreak=↪\ 
set textwidth=80

augroup vimrc
  autocmd!
  autocmd WinClosed * silent! lclose
augroup end

" Mappings {{{1

command! -nargs=* Nxonoremap nnoremap <args>|xnoremap <args>|onoremap <args>

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

" Map window motions to g prefixed lowercased ones
Nxonoremap gh H
Nxonoremap gl L
Nxonoremap gm M

" H and L are easier than ^ and $
function! Handle_h0()
  let [_, _, i, _] = getpos('.')
  if i < 2
    return '0'
  end
  return getline('.')[:i - 2] =~ '^\s*$' ? '0' : '^'
endfunction
Nxonoremap <expr> H (v:count == 0 ? Handle_h0() : '|')
Nxonoremap gH g^
Nxonoremap L $
Nxonoremap gL g$

" Map M to ' (' is the opposite of m)
Nxonoremap M '

nnoremap <S-Tab> <Cmd>exec v:count1 . 'bprev!'<CR>zv
nnoremap <Tab>   <Cmd>exec v:count1 . 'bnext!'<CR>zv

" Page Up and Page Down
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

" Map s to window navigation prefix
nnoremap s <C-w>
nnoremap S <NOP>

nnoremap \ za
nnoremap <Bar> zA

nnoremap <Leader>rr <Cmd>source $MYVIMRC<CR>
nnoremap <Leader>re <Cmd>edit $MYVIMRC<CR>

nnoremap ]] ][
nnoremap ][ ]]

nnoremap <Leader>ss <Cmd>call ktchen14#show_syntax()<CR>

" Abbreviations and Digraphs {{{1

function! AbbreviatePrefix(prefix, to) abort
  return getcmdtype() . getcmdline() ==# ':' . a:prefix ? a:to : a:prefix
endfunction

cnoreabbrev <expr> lgrep AbbreviatePrefix('lgrep', 'silent lgrep')
cnoreabbrev <expr> lgr AbbreviatePrefix('lgr', 'silent lgrep')
cnoreabbrev <expr> grep AbbreviatePrefix('grep', 'silent grep')
cnoreabbrev <expr> gr AbbreviatePrefix('gr', 'silent grep')
cnoreabbrev <expr> lgrepadd AbbreviatePrefix('lgrepadd', 'silent lgrepadd')
cnoreabbrev <expr> lgrepa AbbreviatePrefix('lgrepa', 'silent lgrepadd')
cnoreabbrev <expr> grepadd AbbreviatePrefix('grepadd', 'silent grepadd')
cnoreabbrev <expr> grepa AbbreviatePrefix('grepa', 'silent grepadd')

" Digraphs for ⇜, ⇝, ⟨, and ⟩
digraph <~ 8668 ~> 8669 <m 10216 >m 10217

" Global Filetype {{{1

" Override ftplugin specific 'formatoptions'
augroup vimrc
  autocmd FileType * setlocal formatoptions<
augroup end

let is_bash = 1
let sh_no_error= 1

let c_gnu = 1
let c_no_curly_error = 1
let c_syntax_for_h = 1

" Plugin Configuration {{{1

" aerial.nvim

nnoremap <Leader>tt <Cmd>AerialToggle!<CR>

" vim-plug

" Set the plug window height based on the number of plugs
let plug_window = 'botright ' . (len(plugs) + 4) . 'new'

" cscope-auto

if has('cscope')
  let cscope_auto_database_name = '.cscope'
endif

" fzf

autocmd FileType fzf silent! tunmap <Esc>
nnoremap <C-P> <Cmd>FZF!<CR>

let fzf_layout = #{window: #{width: 0.8, height: 0.8}}
let fzf_vim = #{preview_window: []}
let fzf_vim.buffers_options = ['--prompt', 'Buffer› ']
nnoremap Sb <Cmd>Buffers<CR>
nnoremap SS <Cmd>GFiles<CR>

" vim-easy-align

nmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>A <Plug>(LiveEasyAlign)
xmap <Leader>a <Plug>(EasyAlign)
xmap <Leader>A <Plug>(LiveEasyAlign)

" vim-markdown

let markdown_fenced_languages = ['bash=sh', 'python']

" }}}1

" vim: set foldmethod=marker:
