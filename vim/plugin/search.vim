if exists('g:plugin_search')
  finish
endif
let g:plugin_search = 1

function! NextPrevSearch(direction)
  let flags = ''
  if a:direction ==# 'N'
    let flags = 'b'
  endif
  call search(@/, flags)
  call HLCurrent()
endfunction

" highlight current search and first/last search differently
function! HLCurrent() abort
  if exists("currmatch")
    call matchdelete(currmatch)
  endif
  if exists("*anzu#search_status")
    :AnzuUpdateSearchStatus
  endif
  " only on cursor
  let patt = '\c\%#'.@/
  " check prev and next match
  let prevmatch = search(@/, 'bWn')
  let nextmatch = search(@/, 'Wn')
  " if on first or last match
  if prevmatch == 0 || nextmatch == 0
    let currmatch = matchadd('EdgeSearch', patt, 101)
  else
    let currmatch = matchadd('IncSearch', patt, 101)
  endif
  redraw
endfunction
