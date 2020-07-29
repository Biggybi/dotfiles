setlocal colorcolumn=81
setlocal suffixesadd=.bash,.sh

" easy shebang
inoremap <buffer> <expr> ! col('.') == 2 && getline('.') =~ "^#" ? "!/bin/bash" : "!"
inoremap <buffer> ,#! #!/bin/bash

" alias to function
nnoremap <buffer> <leader>xf ^dWf=2s() {<cr><esc>$x==o}<esc>

" auto close brackets
inoremap <buffer> { {}<c-g>U<left>
inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'
inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'
