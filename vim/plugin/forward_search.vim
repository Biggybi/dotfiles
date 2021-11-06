if exists('g:plugin_forward_search')
  finish
endif
let g:plugin_forward_search = 1

function! s:searchNext()
  return printf('Nn'[v:searchforward])
endfunction

function! s:searchPrev()
  return printf('nN'[v:searchforward])
endfunction

nnoremap <expr> n <sid>searchNext()
nnoremap <expr> N <sid>searchPrev()

nnoremap <expr> : getcharsearch().forward ? ';' : ','
nnoremap <expr> , getcharsearch().forward ? ',' : ';'

" nnoremap <silent><expr> f <Plug>smart_line_search('f')
" nnoremap <silent><expr> t <Plug>smart_line_search('t')
