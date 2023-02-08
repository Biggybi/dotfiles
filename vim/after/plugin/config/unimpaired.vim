if exists('g:plugin_unimpaired')
  finish
endif
let g:plugin_unimpaired = 1

if mapleader == "\<space>"
  unmap ]<space>
  unmap [<space>
endif
