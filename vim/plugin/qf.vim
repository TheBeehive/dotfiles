if exists('g:loaded_qf')
  finish
endif
let g:loaded_qf = 1

nnoremap <Leader>q <Cmd>call qf#toggle()<CR>

if exists('&quickfixtextfunc')
  set quickfixtextfunc=qf#textfunc
endif

" Open the quickfix window on :grep
augroup qf
  autocmd!
  autocmd QuickFixCmdPost grep botright copen
augroup end
