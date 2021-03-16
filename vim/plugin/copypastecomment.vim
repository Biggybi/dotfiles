if exists('g:plugin_copypastecomment')
  finish
endif
let g:plugin_copypastecomment = 1

function! s:cpc(...) abort
  if ! exists('g:loaded_commentary')
    echom "Error : CopyPasteComment: depend on `vim-commentary` [https://github.com/tpope/vim-commentary]."
  endif

  if !a:0
    echo matchstr(expand('<sfile>'), '[^. ]*$')
    " Hail Tpope for thy tricks
    " plugin/commentary.vim:28:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  endif

  if a:0 <= 1 " normal mode
    let [curLine, curCol] = getpos('.')[1:2]
    :'[,']yank *
    :'[put!
    :'[,']Commentary
    normal j_
    return
  endif

  if a:0 > 1 " visual mode
    exe ':' . a:1 . ',' . a:2 'yank *'
    exe ':' . a:1 . 'put!'
    exe ':' . a:1 . ',' . a:2 'Commentary'
    call cursor(line("']") + 1, 0)
    normal _
  endif
endfunction

nnoremap <expr> <Plug>Cpc     <sid>cpc()
xnoremap <expr> <Plug>Cpc     <sid>cpc()
nnoremap <expr> <Plug>CpcLine <sid>cpc() . '_'

if !hasmapto('<Plug>Cpc') || maparg('yc','n') ==# ''
  nmap yc  <Plug>Cpc
  xmap gyc <Plug>Cpc
  nmap ycc <Plug>CpcLine
endif
