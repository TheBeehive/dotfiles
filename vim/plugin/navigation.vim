if exists('g:loaded_navigation')
  finish
endif
let g:loaded_navigation = 1

nnoremap [b <Cmd>exec '' . (v:count ? v:count : '') . 'bprev'<CR>zv
nnoremap [B <Cmd>exec '' . (v:count ? v:count : '') . 'bfirst'<CR>zv
nnoremap ]b <Cmd>exec '' . (v:count ? v:count : '') . 'bnext'<CR>zv
nnoremap ]B <Cmd>exec '' . (v:count ? v:count : '') . 'blast'<CR>zv

nnoremap [q <Cmd>exec '' . (v:count ? v:count : '') . 'cprev'<CR>zv
nnoremap [Q <Cmd>exec '' . (v:count ? v:count : '') . 'cfirst'<CR>zv
nnoremap ]q <Cmd>exec '' . (v:count ? v:count : '') . 'cnext'<CR>zv
nnoremap ]Q <Cmd>exec '' . (v:count ? v:count : '') . 'clast'<CR>zv

nnoremap [l <Cmd>exec '' . (v:count ? v:count : '') . 'lprev'<CR>zv
nnoremap [L <Cmd>exec '' . (v:count ? v:count : '') . 'lfirst'<CR>zv
nnoremap ]l <Cmd>exec '' . (v:count ? v:count : '') . 'lnext'<CR>zv
nnoremap ]L <Cmd>exec '' . (v:count ? v:count : '') . 'llast'<CR>zv
