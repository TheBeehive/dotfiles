if exists('b:did_ftplugin') && b:did_ftplugin == 2
  finish
endif
let b:did_ftplugin = 2

if &commentstring ==# '"%s'
 setlocal commentstring=\"\ %s
endif

setlocal textwidth=78
let b:undo_ftplugin .= '| setl tw<'
