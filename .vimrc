""" ~/.vimrc: Personal configuration for vim

" Use better searching
set hlsearch incsearch

" Disable folding
set nofoldenable
set foldcolumn=0

" Split right and below
set splitright
set splitbelow

" Turn on autoindenting
set nosmartindent
set nocindent
set autoindent

" Disable mouse integration
set mouse=

" Turn on line breaks
set linebreak

" Some helpful mappings
nmap U :redo<CR>
nmap <F2> :nohlsearch<CR>

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
