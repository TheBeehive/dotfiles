if exists('b:did_ftplugin') && b:did_ftplugin == 2
  finish
endif
let b:did_ftplugin = 2

setlocal commentstring=/*\ %s\ */
let b:undo_ftplugin .= '| setl cms<'
