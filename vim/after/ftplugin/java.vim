setlocal colorcolumn=81
setlocal suffixesadd=.java
setlocal path+=inc,incs,includes,include,src,sources,source

setlocal makeprg=java\ \%
setlocal errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#

nnoremap <buffer> <leader>ct :VShell make test<cr>

nnoremap <buffer> <leader>ca :CocAction<cr>
nnoremap <buffer> <leader>cg :Shell gradle run<cr>

" auto close brackets
inoremap <buffer> ( ()<c-g>U<left>
inoremap <buffer> [ []<c-g>U<left>
inoremap <buffer> { {}<c-g>U<left>

inoremap <buffer> <expr> ) getline('.')[col('.')-1]==')' ? '<c-g>U<right>' : ')'
inoremap <buffer> <expr> ] getline('.')[col('.')-1]==']' ? '<c-g>U<right>' : ']'
inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'
inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'

" inoremap <buffer> ,if if ()<cr>{<cr>}<c-o>2<up><c-o>f)
" inoremap <buffer> ,wh while ()<cr>{<cr>}<c-o>2<up><c-o>f)
" inoremap <buffer> ,imin -2147483648
" inoremap <buffer> ,imax 2147483647

" if to ternary operator
nnoremap <buffer> <leader>xt $Ji<space>?<esc>$i : 0<esc>^dw
nnoremap <buffer> <leader>xT ^iif<space>(<esc>f?h3s)<cr><esc>f:h3s;<cr>else<cr><esc>
nnoremap <buffer> <leader>x<c-t> ^iif<space>(<esc>f?h3s)<cr><esc>f:hc$;<esc>

" brackets auround paragraph
nnoremap <buffer> <leader>{} mz{S{<esc>}S}<esc>=%`z=iB
nnoremap <buffer> <leader>{{ o}<esc>kO{<esc>3==j

"  name of current function (needs '()')
nnoremap <buffer> <silent> g<c-d> ][[[h^t(b

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
if ! empty('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
endif
let b:undo_ftplugin .= "setlocal colorcolumn< suffixesadd< path< makeprg<"
