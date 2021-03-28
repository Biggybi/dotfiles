if exists('g:plugin_copypastecomment')
  finish
endif
let g:plugin_copypastecomment = 1

let s:curpos = []

function! s:cpc(...) abort
  if ! exists('g:loaded_commentary')
    echom "Error : CopyPasteComment: depend on `vim-commentary`"
    echom "[https://github.com/tpope/vim-commentary]."
  endif

  if !a:0
    if s:curpos == []
      let s:curpos = getpos('.')[1:2]
    endif
    " Hail Tpope for thy tricks plugin/commentary.vim:28:0
    " -> recall this function in normal mode, with lines auto arguments
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  endif

  '[,']yank *
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

if !hasmapto('<Plug>Cpc') || maparg('yc','n') ==# ''
  nmap gyc  <Plug>Cpc
  xmap gyc <Plug>Cpc
  nmap gycc <Plug>CpcLine
endif
