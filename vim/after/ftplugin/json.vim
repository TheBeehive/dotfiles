if exists('b:did_ftplugin') && b:did_ftplugin == 2
  finish
endif
let b:did_ftplugin = 2

if executable('jq')
  setlocal formatprg=jq\ .
  let b:undo_ftplugin .= '| setl fp<'
endif
