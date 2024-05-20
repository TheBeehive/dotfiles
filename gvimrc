""" ~/.gvimrc: Runtime configuration for `gvim`

" Use this for GUI vim which updates faster than the terminal
set relativenumber

set visualbell t_vb=

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=t
set guioptions-=T

if has("gui_macvim")
  set guifont=Monaco:h12
  set transparency=10
elseif has('win32')
  set guifont=Consolas:h11
  set renderoptions=type:directx
  set winaltkeys=no
  set lines=42
  set columns=120
endif
