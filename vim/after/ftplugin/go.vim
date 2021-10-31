setlocal colorcolumn=81
setlocal foldmethod=syntax
setlocal suffixesadd=.go
setlocal path=inc,incs,includes,include,src,sources,source

" compile and execute current
nnoremap <buffer> <leader>cc      :exe "VShell ++shell go build " . expand('%') . " && ./" . expand('%:r')<cr>
nnoremap <buffer> <leader>cC      :!gcc -Wall -Wextra % && ./a.out<cr>
nnoremap <buffer> <leader>cs      :Shell gcc -Wall -Wextra % && ./a.out<cr>
nnoremap <buffer> <leader>cs<c-m> :Shell gcc -Wall -Wextra % main.c && ./a.out<cr>

" auto close brackets
inoremap <buffer> ( ()<c-g>U<left>
inoremap <buffer> [ []<c-g>U<left>
inoremap <buffer> { {}<c-g>U<left>

inoremap <buffer> <expr> ) getline('.')[col('.')-1]==')' ? '<c-g>U<right>' : ')'
inoremap <buffer> <expr> ] getline('.')[col('.')-1]==']' ? '<c-g>U<right>' : ']'
inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'
inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'

inoremap <buffer> " ""<c-g>U<left>
inoremap <buffer> ' ''<c-g>U<left>
inoremap <buffer> ` ``<c-g>U<left>

" jump to declaration of current function
nnoremap <buffer> <silent> <leader>gm :call search("func", 'b')<cr>
nnoremap <buffer> <silent> ]m :call search("func", 'W')<cr>
nnoremap <buffer> <silent> [m :call search("func", 'bW')<cr>

" select all text in function
nnoremap <buffer> <leader>vm ][v%

" " make
" nnoremap <leader>ce :VShell make test<cr>
" nnoremap <leader>ct :VShell make test TESTFF=test/test*<cr>
" nnoremap <leader>cT :VShell make test TESTFF=
" nnoremap <leader>cb :VShell make build<cr>
" nnoremap <leader>cn :exe 'Shell norminette.rb' expand('%:p')<cr>
" nnoremap <leader>cN :exe 'Shell norminette.rb' expand('.')<cr>

" " debug
" nnoremap <leader>cv :VShell make valgrind<cr>
" nnoremap <leader>cg :tabnew<bar>Termdebug<cr>

" lsp
" switch to header file
if exists(":CocCommand")
  nnoremap <leader>hh :CocCommand clangd.switchSourceHeader<cr>
endif
