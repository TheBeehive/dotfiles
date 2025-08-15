if exists('g:loaded_status_symbol_hilite') || !has('termguicolors')
  finish
endif
let g:loaded_status_symbol_hilite = 1

hi TabLine                              guifg=#6c7086 guibg=#181825
hi TabLineFill                          guifg=#313244 guibg=#181825
hi TabLineSel                           guifg=#cdd6f4 guibg=#45475a

hi StatusSymbolModeNormal               guifg=#181825 guibg=#89b4fa
hi StatusSymbolModeVisual               guifg=#1e1e2e guibg=#cba6f7
hi StatusSymbolModeInsert               guifg=#1e1e2e guibg=#94e2d5
hi StatusSymbolModeReplace              guifg=#1e1e2e guibg=#f38ba8
hi StatusSymbolModeCommand              guifg=#1e1e2e guibg=#fab387

hi StatusSymbolActiveBufferModifiedMark guifg=#a6e3a1 guibg=#45475a
hi StatusSymbolActiveBufferReadonlyMark guifg=#f38ba8 guibg=#45475a

hi StatusSymbolNormalBuffer             guifg=#cdd6f4 guibg=#181825
hi StatusSymbolNormalBufferModifiedMark guifg=#a6e3a1 guibg=#181825
hi StatusSymbolNormalBufferReadonlyMark guifg=#f38ba8 guibg=#181825
