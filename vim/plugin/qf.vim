if exists('g:loaded_qf')
  finish
endif
let g:loaded_qf = 1

nnoremap <Leader>q <Cmd>call qf#toggle()<CR>
