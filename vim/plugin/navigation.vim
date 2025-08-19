if exists('g:loaded_navigation')
  finish
endif
let g:loaded_navigation = 1

" Arguments
nnoremap ]a     <Cmd>exec v:count1 . 'next'<CR>zv
nnoremap [a     <Cmd>exec v:count1 . 'prev'<CR>zv
nnoremap ]a     <Cmd>last<CR>zv
nnoremap [a     <Cmd>first<CR>zv

" Buffers
nnoremap ]b     <Cmd>exec v:count1 . 'bnext'<CR>zv
nnoremap [b     <Cmd>exec v:count1 . 'bprev'<CR>zv
nnoremap ]B     <Cmd>blast<CR>zv
nnoremap [B     <Cmd>bfirst<CR>zv

" QuickFix List items
nnoremap ]q     <Cmd>exec v:count1 . 'cafter'<CR>zv
nnoremap [q     <Cmd>exec v:count1 . 'cbefore'<CR>zv
nnoremap ]<M-q> <Cmd>exec v:count1 . 'cnext'<CR>zv
nnoremap [<M-q> <Cmd>exec v:count1 . 'cprev'<CR>zv
nnoremap ]Q     <Cmd>clast<CR>zv
nnoremap [Q     <Cmd>cfirst<CR>zv
nnoremap ]<C-q> <Cmd>exec v:count1 . 'cnfile'<CR>zv
nnoremap [<C-q> <Cmd>exec v:count1 . 'cpfile'<CR>zv

" Location List items
nnoremap ]l     <Cmd>exec v:count1 . 'lafter'<CR>zv
nnoremap [l     <Cmd>exec v:count1 . 'lbefore'<CR>zv
nnoremap ]<M-l> <Cmd>exec v:count1 . 'lnext'<CR>zv
nnoremap [<M-l> <Cmd>exec v:count1 . 'lprev'<CR>zv
nnoremap ]L     <Cmd>llast<CR>zv
nnoremap [L     <Cmd>lfirst<CR>zv
nnoremap ]<C-l> <Cmd>exec v:count1 . 'lnfile'<CR>zv
nnoremap [<C-l> <Cmd>exec v:count1 . 'lpfile'<CR>zv

" Tags
nnoremap ]t     <Cmd>exec v:count1 . 'tnext'<CR>zv
nnoremap [t     <Cmd>exec v:count1 . 'tprev'<CR>zv
nnoremap ]t     <Cmd>tlast<CR>zv
nnoremap [t     <Cmd>tfirst<CR>zv
