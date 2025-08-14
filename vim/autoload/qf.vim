" Toggle the Quickfix List window
function! qf#toggle() abort
  if getqflist({ 'winid': 1 }).winid
    cclose
  else
    botright copen
    wincmd p
  endif
endfunction
