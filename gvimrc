""" ~/.gvimrc: Runtime configuration for `gvim`

" Use this for GUI vim which updates faster than the terminal
set relativenumber

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" Only supported in MacVim
if has("gui_macvim")
  set transparency=10
endif

""" ~/.gvimrc: Runtime configuration for `gvim`
