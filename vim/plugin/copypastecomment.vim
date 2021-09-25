if exists('g:plugin_copypastecomment')
  finish
endif
let g:plugin_copypastecomment = 1

let s:curpos = []

function! s:cpc(...) abort
  if !a:0
    if s:curpos == []
      let s:curpos = getpos('.')[1:2]
    endif
    " Hail Tpope for thy tricks plugin/commentary.vim:28:0
    " -> recall this function in normal mode, with lines auto arguments
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  endif

  '[,']yank
  '[put!
  '[,']Commentary
  if s:curpos != []
    call cursor(s:curpos[0] + line("']") - line("'[") + 1, s:curpos[1], 1)
  endif
  let s:curpos = []
endfunction

nnoremap <expr> <Plug>Cpc     <sid>cpc()
xnoremap <expr> <Plug>Cpc     <sid>cpc()
nnoremap <expr> <Plug>CpcLine <sid>cpc() . '_'

if !hasmapto('<Plug>Cpc')
  if maparg('gycc','n') ==# ''
    nmap gycc <Plug>CpcLine
  endif
  if maparg('gyc','n') ==# ''
    nmap gyc <Plug>Cpc
  endif
  if maparg('gyc','x') ==# ''
    xmap gyc <Plug>Cpc
  endif
  if maparg('yc','n') ==# ''
    nmap yc <Plug>Cpc
    nmap ycc <Plug>CpcLine
  endif
endif
