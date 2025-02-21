if exists('g:loaded_cscope') || !has('cscope')
  finish
endif
let g:loaded_cscope = 1

" Show cscope command result in the quickfix window
setg cscopequickfix=s-,c-,d-,i-,t-,e-,a-

" Open the quickfix window on a cscope command
augroup cscope
  autocmd!
  autocmd QuickFixCmdPost cscope botright copen
augroup end

" Find this C symbol
nnoremap <Leader>cs :cs find s
nnoremap <Leader>cS <Cmd>cs find s <C-r>=expand("<cword>")<CR><CR>

" Find this global definition
nnoremap <Leader>cg :cs find g
nnoremap <Leader>cG <Cmd>cs find g <C-r>=expand("<cword>")<CR><CR>

" Find functions called by this function
nnoremap <Leader>cd :cs find d
nnoremap <Leader>cD <Cmd>cs find d <C-r>=expand("<cword>")<CR><CR>

" Find functions calling this function
nnoremap <Leader>cc :cs find c
nnoremap <Leader>cC <Cmd>cs find c <C-r>=expand("<cword>")<CR><CR>

" Find this text string
nnoremap <Leader>ct :cs find t
nnoremap <Leader>cT <Cmd>cs find t <C-r>=expand("<cword>")<CR><CR>

" Find this egrep pattern
nnoremap <Leader>ce :cs find e
nnoremap <Leader>cE <Cmd>cs find e <C-r>=expand("<cword>")<CR><CR>

" Find this file
nnoremap <Leader>cf :cs find f
nnoremap <Leader>cF <Cmd>cs find f <C-r>=expand("<cword>")<CR><CR>

" Find files #including this file
nnoremap <Leader>ci :cs find i
nnoremap <Leader>cI <Cmd>cs find i <C-r>=expand("<cword>")<CR><CR>

" Find assignments to this symbol
nnoremap <Leader>ca :cs find a
nnoremap <Leader>cA <Cmd>cs find a <C-r>=expand("<cword>")<CR><CR>
