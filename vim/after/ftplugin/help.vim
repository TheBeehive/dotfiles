if !exists('w:help_once')
  let w:help_once = 1
  wincmd L
  execute 'vertical resize ' . &textwidth
endif

setl bufhidden=unload winfixwidth
