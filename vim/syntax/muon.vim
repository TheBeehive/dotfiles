if exists('b:current_syntax')
  finish
endif

setlocal commentstring=#\ %s

syntax keyword muonKeyword define lambda switch
syntax keyword muonKeywordCase case
syntax keyword muonKeywordDatatype datatype
syntax match muonComment '#[ \t].*$'
syntax match muonInteger '\<\(0\|[1-9][0-9]*\)\>'

highlight default link muonComment         Comment
highlight default link muonInteger         Number
highlight default link muonKeyword         Keyword
highlight default link muonKeywordCase     Label
highlight default link muonKeywordDatatype Typedef

let b:current_syntax = 'muon'
