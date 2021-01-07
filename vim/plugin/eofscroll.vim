if exists('g:plugin_eofscroll')
  finish
endif
let g:plugin_eofscroll = 1

" Do not scroll past the end of file (last line locked at bottom of window)
function! NoScrollAtEOF() abort
  let curpos = getpos('.')
  let lnum = get(curpos, 1, -1)
  let len = line('$')
  if lnum + winheight(0) >= len
    normal! zb
  endif
endfunction

nnoremap <c-d> <silent> <c-d>:call NoScrollAtEOF()<cr>
