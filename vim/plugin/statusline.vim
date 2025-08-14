if exists('g:loaded_statusline')
  finish
endif
let g:loaded_statusline = 1

function! StatusLine() abort
  let result = '[%{winnr()}] %f%='

  " [filetype? | fileformat? | fileencoding?]
  let inside = []
  if !empty(&filetype)
    call add(inside, &filetype)
  endif
  if &ff !=# &g:ff
    call add(inside, &ff)
  endif
  if !empty(&fenc) && &fenc !=# &enc
    call add(inside, &fenc)
  endif
  if !empty(inside)
    let result .= '[' . join(inside, '/') . ']  '
  endif

  let column = &tw && col('.') > &tw ? '%#Error#%c%*' : '%c'
  let result .= '%l:' . column . '  '

  let [l, L] = [line('.'), line('$')]
  if l == 1
    let result .= '↑'
  elseif l == L
    let result .= '↓'
  else
    let result .= string(l * 100 / L) . '%%'
  endif
  return result . ' of %L'
endfunction
set statusline=%{%StatusLine()%}
