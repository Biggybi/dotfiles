if exists('g:plugin_count')
  finish
endif
let g:plugin_count = 1

" Word count
function! s:wordCount() abort
  let shellsave=&shell
  let &shell='sh'
  echo system("detex " . expand("%") . " | wc -w | tr -d [[:space:]]") "words"
  let shell=shellsave
endfunction

function! s:countRealLines() abort
  let s:count = 0
  let view = winsaveview()
  " Nomove g/^[^$,\"]/let s:count += 1
  g/^[^$,\"]/let s:count += 1
  let ret = s:count
  let s:count = 0
  call winrestview(view)
  echo ret . " lines"
endfunction

nnoremap <silent> <leader>wcc :call <sid>wordCount()<cr>
nnoremap <silent> <leader>wcw :call <sid>wordCount()<cr>
nnoremap <silent> <leader>wcl :call <sid>countRealLines()<cr>
