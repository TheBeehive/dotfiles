" Useful to debug a colorscheme or syntax highlighting
function! ktchen14#show_syntax() abort
  let synids = reverse(synstack(line('.'), col('.')))
  let syntax = map(copy(synids), 'synIDattr(v:val, "name")')
  call map(synids, 'synIDtrans(v:val)')
  let hilite = map(copy(synids), 'synIDattr(v:val, "name")')

  echon ''

  for i in range(len(hilite))
    if i > 0 | echon ' « ' | endif

    exec 'echoh ' . hilite[i] | echon hilite[i] | echoh None

    if hilite[i] ==# syntax[i]
      continue
    endif

    echon ' '
    echon '('
    exec 'echoh ' . syntax[i] | echon syntax[i] | echoh None
    echon ')'
  endfor
endfunc
