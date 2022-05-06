if exists('g:plugin_forward_search')
  finish
endif
let g:plugin_forward_search = 1

function! s:searchNext()
  return printf('Nn'[v:searchforward] . ":echo '/'.@/")
endfunction

function! s:searchPrev()
  return printf('nN'[v:searchforward] . ":echo '?'.@/")
endfunction

nnoremap <silent> <expr> n <sid>searchNext()."<cr>"
nnoremap <silent> <expr> N <sid>searchPrev()."<cr>"

nnoremap <expr> : getcharsearch().forward ? ';' : ','
nnoremap <expr> , getcharsearch().forward ? ',' : ';'

vnoremap <expr> : getcharsearch().forward ? ';' : ','
vnoremap <expr> , getcharsearch().forward ? ',' : ';'
" nnoremap <silent><expr> f <Plug>smart_line_search('f')
" nnoremap <silent><expr> t <Plug>smart_line_search('t')
