if exists('g:plugin_pathogen')
  finish
endif
let g:plugin_pathogen = 1

command! -bar Helptags :call pathogen#helptags()
