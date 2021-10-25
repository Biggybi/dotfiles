if exists('g:plugin_trailspace')
  finish
endif
let g:plugin_trailspace = 1

function! s:TrailSpace(pattern)
  try
    exe "match TrailSpace" a:pattern
  catch /^Vim\%((\a\+)\)\=:E28/
  endtry
endfunction

augroup TrailSpace
  au!
  au BufEnter,WinEnter,InsertLeave *
        \ call <sid>TrailSpace("\/\\s\\+$\/")
  au InsertEnter *
        \ call <sid>TrailSpace("\/\\s\\+\%#\\@<!$\/")
  au BufWinLeave *
        \ call clearmatches()
augroup end
