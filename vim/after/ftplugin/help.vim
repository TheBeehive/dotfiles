if exists('w:did_help_ftplugin')
  finish
endif
let w:did_help_ftplugin = 1

wincmd L
execute 'vertical resize ' . &textwidth

setlocal bufhidden=unload winfixwidth
let b:undo_ftplugin .= '| setl bh< wfw<'
