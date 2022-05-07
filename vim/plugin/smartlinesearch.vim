" courtesy of Christian Brabandt
" https://vi.stackexchange.com/a/15361/22375

" Note: breaks modecolor for `f` and `t`

if exists('g:plugin_smart_line_search')
  finish
endif
finish
let g:plugin_smart_line_search = 1

if !hasmapto('Plug<SlsF>') || maparg('f','n') ==# ''
  nmap <silent> f <Plug>SlsF
endif
if !hasmapto('Plug<SlsT>') || maparg('t','n') ==# ''
  nmap <silent> t <Plug>SlsT
endif

nnoremap <expr> <Plug>SlsF <sid>smart_line_search('f')
nnoremap <expr> <Plug>SlsT <sid>smart_line_search('t')

function! s:smart_line_search(cmd) abort
  let arg=getchar()
  if arg !~ '^\d\+'
    " no real key, mouse click  or something unusual, so abort
    return a:cmd."\<esc>"
  else
    let arg=nr2char(arg)
  endif
  let pat='\%'.line('.').'l\V'.escape(arg,'\\')
  if search(pat,'nWz')
    return a:cmd.arg
  else
    return nr2char(char2nr(a:cmd)-32).arg
  endif
endfu
