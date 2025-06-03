setl nobuflisted nonumber winfixbuf

function! QuickFixStatusLine()
  let result = '[%{winnr()}] %t'
  if exists('w:quickfix_title')
    let result .= ' ' . w:quickfix_title
  endif
  let result .= '%='

  let result .= '%l:%c  '
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
setl statusline=%{%QuickFixStatusLine()%}
