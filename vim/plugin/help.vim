if exists('g:loaded_help')
  finish
endif
let g:loaded_help = 1

function! HelpWindow() abort
  if exists('w:help_once')
    return
  endif
  let w:help_once = 1

  wincmd L
  execute 'vertical resize ' . &textwidth
  setlocal winfixwidth
endfunction

augroup help
  autocmd!
  autocmd BufWinEnter * if &filetype ==# 'help' | call HelpWindow() | endif
augroup end
