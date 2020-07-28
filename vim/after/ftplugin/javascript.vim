nnoremap <buffer> <leader>cr :Run<cr>
nnoremap <buffer> <leader>ca :AutoRun<cr>
nnoremap <buffer> <leader>; i<c-o>mZ<c-o>A;<esc>`Z<esc>
nnoremap <buffer> <leader>, i<c-o>mZ<c-o>A,<esc>`Z<esc>
nnoremap <buffer> <leader>cc :Shell node %<cr>
nnoremap <buffer> <leader>ls :!live-server %<cr>
inoremap <buffer> ,if if ()<cr>{<cr>}<esc>2k3==f)i
inoremap <buffer> ,fo for ()<cr>{<cr>}<esc>2k3==f)i
inoremap <buffer> ,wh while ()<cr>{<cr>}<esc>2k3==f)i
inoremap <buffer> ,cl console.log();<esc>F)i
nnoremap <buffer> <leader>xl yiwoconsole.log();<esc>F(p
vnoremap <buffer> <leader>xl yoconsole.log();<esc>F(p

" auto close brackets
inoremap <buffer> { {}<c-g>U<left>
inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'
inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'
