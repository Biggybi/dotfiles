nnoremap <buffer> <expr> <leader>; getline('.')[col('$') - 2] == ';' ? "mZ$x`Z" : "mZA;\<esc>`Z"
nnoremap <buffer> <expr> <leader>, getline('.')[col('$') - 2] == ',' ? "mZ$x`Z" : "mZA,\<esc>`Z"

" auto close brackets
inoremap <buffer> { {}<c-g>U<left>
inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'
inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'
