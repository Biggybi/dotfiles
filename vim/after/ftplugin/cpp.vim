setlocal colorcolumn=81
setlocal foldmethod=syntax
setlocal suffixesadd=.c,.h,.cpp
setlocal colorcolumn=81
setlocal path+=inc,incs,includes,include,src,sources,source

inoremap <buffer> ,ma <esc>:Header101<cr>iint<tab><tab>main(int ac, char **av)<cr>{<cr>}<esc>Oreturn(0);<esc>O
inoremap <buffer> ,if if ()<cr>{<cr>}<esc>2k3==f)i
inoremap <buffer> ,wh while ()<cr>{<cr>}<esc>2k3==f)i
inoremap <buffer> ,ret return (0);<esc>^
inoremap <buffer> ,imin -2147483648
inoremap <buffer> ,imax 2147483647
inoremap <buffer> ,endl ft_putendl("");<left><left><left>
inoremap <buffer> ,str ft_putstr("");<left><left><left>
inoremap <buffer> ,nbr ft_putnbr();<cr>ft_putendl("");<up><left><left>
inoremap <buffer> ,lib #include <stdlib.h><cr>#include <unistd.h><cr>#include <stdio.h><cr>#include <sys/types.h><cr>#include <sys/wait.h><cr>#include <sys/types.h><cr>#include <sys/stat.h><cr>#include <fcntl.h><cr>#include <string.h><cr>#include <bsd/string.h><cr>

" if to ternary operator
nnoremap <buffer> <leader>xt $Ji<space>?<esc>$i : 0<esc>^dw
nnoremap <buffer> <leader>xT ^iif<space>(<esc>f?h3s)<cr><esc>f:h3s;<cr>else<cr><esc>
nnoremap <buffer> <leader>x<c-t> ^iif<space>(<esc>f?h3s)<cr><esc>f:hc$;<esc>

" compile and execute current
nnoremap <buffer> <leader>c. :Shell gcc -Wall -Wextra % && ./a.out<cr>
nnoremap <buffer> <leader>cc :Shell gcc -Wall -Wextra % main.c && ./a.out<cr>

" auto close brackets
inoremap <buffer> { {}<c-g>U<left>
inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'
inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'

" brackets around paragraph
nnoremap <buffer> <leader>{} mz{S{<esc>}S}<esc>=%`z=iB
nnoremap <buffer> <leader>{{ o}<esc>kO{<esc>3==j

"  name of current c,cpp function (needs '()')
nnoremap <buffer> <silent> g<c-d> ][[[h^t(b

" semicolon/coma EOL toggle
nnoremap <buffer> <expr> <leader>; getline('.')[col('$') - 2] == ';' ? "mz$x`z" : "mzA;\<esc>`z"
nnoremap <buffer> <expr> <leader>, getline('.')[col('$') - 2] == ',' ? "mz$x`z" : "mzA,\<esc>`z"

" select all text in function
nnoremap <buffer> <leader>vf j[[V%o

" valgrind
nnoremap <leader>cv :VShell make valgrind<cr>
