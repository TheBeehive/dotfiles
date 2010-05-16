""" ~/.vimrc: Personal configuration for vim

" Some default options that make sense
set backspace=indent,eol,start
set nobackup
set nowritebackup
set ruler
set showcmd
set visualbell t_vb=

" Split right and below
set splitright
set splitbelow

" Highlight current line
set cursorline

" Show line numbers
set number
set numberwidth=4

" Disable folding
set nofoldenable
set foldcolumn=0

" Set tab size to two spaces
set shiftwidth=2
set expandtab
set softtabstop=2

" Use better searching
set hlsearch incsearch

" Turn on automatic indenting
set nosmartindent
set nocindent
set autoindent

" Turn off mouse integration
set mouse=

" Turn on line breaks
set linebreak

" Some helpful mappings
nmap U :redo<CR>
nmap <F2> :nohlsearch<CR>

" Turn on syntax highlighting
syntax on

" Use our custom colorscheme
colorscheme kiwilight

" Turn off indenting scripts
filetype plugin indent off
" HTML rendering sucks too
let html_no_rendering = 1
" Turn off auto commenting
autocmd Filetype * set formatoptions-=ro

" Run Javascript Lint
cabbr jsl !js ~/check.js "`cat %`"

" Split help vertically
cabbr helpg vert bo helpg
cabbr help  vert bo help

" Read man and info pages
cabbr info Info
cabbr man Man
runtime ftplugin/man.vim

" Sensible taglist options
let Tlist_Enable_Fold_Column = 0
let Tlist_Display_Tag_Scope  = 0

" Set up both nt and tt
command NERDTreeTlistOpen
  \ NERDTree | TlistOpen |
  \ exe "norm \<C-W>\J" |
  \ exe "norm \<C-W>\k" |
  \ exe "norm \<C-W>\l" |
  \ exe "norm \<C-W>\L" |
  \ exe "norm \<C-W>\h" |
  \ vertical resize 30 |
  \ exe "norm \<C-W>\l"

" Abbreviations for nt and tt
cabbr tt TlistOpen
cabbr nt NERDTree

cabbr tnt NERDTreeTlistOpen
cabbr tta TlistAddFiles
cabbr ttu TlistUpdate
cabbr ttr TlistAddFilesRecursive .
