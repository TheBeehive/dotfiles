if exists('b:did_ftplugin') && b:did_ftplugin == 2
  finish
endif
let b:did_ftplugin = 2

setl nobuflisted nonumber winfixbuf winfixheight nowrap

function! QuickFixStatusLine() abort
  let result = '[%{winnr()}] %t'
  if exists('w:quickfix_title')
    let result .= ' ' . w:quickfix_title
  endif
  let result .= '%=%l:%c  '

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

let b:undo_ftplugin .= '| setl bl< nu< stl< wfb< wfh< wrap<'
