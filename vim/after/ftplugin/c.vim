setlocal colorcolumn=81
setlocal foldmethod=syntax
setlocal suffixesadd=.c,.h
setlocal colorcolumn=81
setlocal filetype=c
setlocal path=inc,incs,includes,include,src,sources,source
" ^\s*#\s*include
" setlocal include=^\s*#\s*inc*

function! s:insertCHHeader() abort
  let path_to_skeletons = "$HOME/dotfiles/vim/skel/skel_header.c"
  " Save cpoptions
  let cpoptions = &cpoptions
  " Remove the 'a' option - prevents the name of the
  " alternate file being overwritten with a :read command
  exe "set cpoptions=" . substitute(cpoptions, "a", "", "g")
  " exe "read " . path_to_skeletons
  exe "read " . path_to_skeletons
  " Restore cpoptions
  exe "set cpoptions=" . cpoptions
  1, 1 delete _
  let fname = expand("%:t")
  let fname = toupper(fname)
  let fname = substitute(fname, "\\.", "_", "g")
  %s/HEADERNAME/\=fname/g
  call search('^$')
endfunction

if line('$') == 1 && empty(getline(1)) && bufname("%") =~? ".h"
  call <sid>insertCHHeader()
  call search('^$')
endif

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
nnoremap <buffer> <leader>cc :!gcc -Wall -Wextra % && ./a.out<cr>
nnoremap <buffer> <leader>cC :!gcc -Wall -Wextra % && ./a.out<cr>
nnoremap <buffer> <leader>csc :Shell gcc -Wall -Wextra % && ./a.out<cr>
nnoremap <buffer> <leader>cs<c-m> :Shell gcc -Wall -Wextra % main.c && ./a.out<cr>

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
nnoremap <buffer> <leader>cv :!valgrind ./test.out 2> /dev/null<cr><cr>
nnoremap <buffer> <leader>csv :Shell valgrind ./test.out 2> /dev/null<cr><cr>
