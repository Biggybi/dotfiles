if exists('g:plugin_forward_search')
  finish
endif
let g:plugin_forward_search = 1

nnoremap <silent> <expr> n 'Nn'[v:searchforward]
nnoremap <silent> <expr> N 'nN'[v:searchforward]
xnoremap <silent> <expr> n 'Nn'[v:searchforward]
xnoremap <silent> <expr> N 'nN'[v:searchforward]

nnoremap <expr> : getcharsearch().forward ? ';' : ','
nnoremap <expr> , getcharsearch().forward ? ',' : ';'

vnoremap <expr> : getcharsearch().forward ? ';' : ','
vnoremap <expr> , getcharsearch().forward ? ',' : ';'
" nnoremap <silent><expr> f <Plug>smart_line_search('f')
" nnoremap <silent><expr> t <Plug>smart_line_search('t')
