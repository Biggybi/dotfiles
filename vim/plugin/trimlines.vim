if exists('g:plugin_trimlines')
  finish
endif
let g:plugin_trimlines = 1

let g:trimlines_pattern = get(g:, 'trimlines_pattern', '\s\+$')

let s:curpos = []

function! s:trim(...) abort
  if !a:0
    if s:curpos == []
      let s:curpos = getpos('.')[1:2]
    endif
    " Hail Tpope for thy tricks: plugin/commentary.vim:28:0
    " -> recall with auto arguments (line marks)
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  endif

  silent! exe "'[,']s/" . g:trimlines_pattern . "/"
  if s:curpos != []
    call cursor(s:curpos[0], s:curpos[1], 1)
  endif
  let s:curpos = []
endfunction

nnoremap <expr> <Plug>Trim     <sid>trim()
xnoremap <expr> <Plug>Trim     <sid>trim()
nnoremap <expr> <Plug>TrimLine <sid>trim() . '_'

if !hasmapto('<Plug>Trim')
  if maparg('dx', 'n') ==# ''
    nmap dx  <Plug>Trim
  endif
  if maparg('gdx', 'n') ==# ''
    nmap gdx <Plug>Trim
  endif
  if maparg('gdxx', 'n') ==# ''
    nmap gdxx <Plug>TrimLine
  endif
  if maparg('dxx', 'n') ==# ''
    nmap dxx <Plug>TrimLine
  endif
  if maparg('d<space>', 'n') ==# ''
    nmap d<space>  <Plug>Trim
  endif
  if maparg('d<space><space>', 'n') ==# ''
    nmap d<space><space> <Plug>TrimLine
  endif
  if maparg('gd<space>', 'x') ==# ''
    xmap gd<space> <Plug>Trim
  endif
  if maparg('gdx', 'x') ==# ''
    xmap gdx <Plug>Trim
  endif
endif
