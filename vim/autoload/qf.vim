" Toggle the Quickfix List window
function! qf#toggle() abort
  if getqflist({ 'winid': 1 }).winid
    cclose
  else
    botright copen
    wincmd p
  endif
endfunction

" Called to render a Quickfix/Location list
function! qf#textfunc(info) abort
  if a:info.quickfix
    let source = getqflist(#{id: a:info.id, items: 1}).items
  else
    let source = getloclist(a:info.winid, #{items: 1}).items
  endif

  let dirsep = '\/'[!exists('+shellslash') || &shellslash]
  let name_length = get(g:, 'qf_name_length', 24)

  let result = []
  let length = 0
  for item in source
    let tail = fnamemodify(bufname(item.bufnr), ':t')
    let head = fnamemodify(bufname(item.bufnr), ':h')

    while 1
      let test = empty(head) || head == '.' ? tail : '…' . dirsep . tail

      if strdisplaywidth(test) > name_length
        break
      endif
      let prefix = test

      if empty(head) || head == '.' | break | endif
      let tail = fnamemodify(head, ':t') . dirsep . tail
      let head = fnamemodify(head, ':h')
    endwhile

    let prefix = printf('%.*S', name_length, prefix)

    if item.lnum
      let prefix .= ':' . item.lnum

      if item.end_lnum && item.end_lnum != item.lnum
        let prefix .= '–' . item.end_lnum
      endif

      if item.col
        let prefix .= ':' . item.col

        if item.end_col && item.end_col != item.col
          let prefix .= '–' . item.end_col
        endif
      endif
    endif

    let length = max([length, strdisplaywidth(prefix)])
    call add(result, prefix)
  endfor

  for i in range(a:info.start_idx - 1, a:info.end_idx - 1)
    let text = trim(source[i].text)
    let result[i] = printf('%*S │ %s', -length, result[i], text)
  endfor
  return result[a:info.start_idx - 1 : a:info.end_idx - 1]
endfunction
