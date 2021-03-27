if exists('g:plugin_trimlines')
  finish
endif
let g:plugin_trimlines = 1

let g:trimlines_pattern = get(g:, 'trimlines_pattern', '\s\+$')

function! s:trim(...) abort
  if !a:0
    echo matchstr(expand('<sfile>'), '[^. ]*$')
    " Hail Tpope for thy tricks: plugin/commentary.vim:28:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  endif

  if a:0 <= 1 " normal mode
    silent! exe "'[,']s/" . g:trimlines_pattern . "/"
    call cursor(line("'["), '_')
    normal _
    return
  endif

  if a:0 > 1 " visual mode
   exe ':silent!' . a:1 . ',' . a:2 . 's/'. g:trimlines_pattern . '//'
  endif
endfunction

nnoremap <expr> <Plug>Trim     <sid>trim()
xnoremap <expr> <Plug>Trim     <sid>trim()
nnoremap <expr> <Plug>TrimLine <sid>trim() . '_'

if !hasmapto('<Plug>Trim') || maparg('yc','n') ==# ''
  nmap dx  <Plug>Trim
  xmap gdx <Plug>Trim
  nmap dxx <Plug>TrimLine
endif
