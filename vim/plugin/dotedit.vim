if exists('g:plugin_dotedit')
  finish
endif
let g:plugin_dotedit = 1

" Quick edit for (n)vim script files

function s:vimDotfilesComplete(a,...) abort
  let vim_dots = filter(glob("~/.vim/plugin/**/*.vim",0,1),
    \ 'v:val =~ a:a')
  let nvim_dots = filter(glob("~/.config/nvim/plugin/**/*.{vim,lua}",0,1),
    \ 'v:val =~ a:a')
  return vim_dots + nvim_dots
endfunction

command -nargs=1 -complete=customlist,<SID>vimDotfilesComplete D
      \ edit <args>
