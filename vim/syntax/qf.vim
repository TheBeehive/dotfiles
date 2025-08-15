if exists('b:current_syntax') || &quickfixtextfunc !=# 'qf#textfunc'
  finish
endif

syntax match qfFileName   '^[^:│]*'            nextgroup=qfSeparator1,qfSeparator2
syntax match qfSeparator1 ':'        contained nextgroup=qfLineNr
syntax match qfLineNr      '[^:│]*'  contained nextgroup=qfSeparator1,qfSeparator2
syntax match qfSeparator2 '│'        contained nextgroup=qfText
syntax match qfText       '.*'       contained

" Hide file name and line number for help outline (TOC)
if has_key(w:, 'qf_toc') || get(w:, 'quickfix_title') =~# '\<TOC$\|\<Table of contents\>'
  setlocal conceallevel=3 concealcursor=nc
  syntax match Ignore     '^[^│]*│ ' conceal
endif

hi def link qfFileName   Directory
hi def link qfLineNr     LineNr
hi def link qfSeparator1 Delimiter
hi def link qfSeparator2 Delimiter
hi def link qfText       Normal

let b:current_syntax = 'qf'
