setlocal colorcolumn=81
setlocal foldmethod=syntax
setlocal suffixesadd=.c,.h
setlocal colorcolumn=81
setlocal filetype=c
setlocal path=inc,incs,includes,include,src,sources,source
" ^\s*#\s*include
" setlocal include=^\s*#\s*inc*

" workaround for makefile: last line would link to a wrong file
setlocal errorformat=%E%f:%l:%c:\ error:%m
setlocal errorformat+=,%W%f:%l:%c:\ warning:%m

function! s:insertCHHeader() abort
  try
    let path_to_skeletons = '$HOME/dotfiles/vim/skel/skel_header.c'
    " Remove the 'a' option - prevents the name of the
    " alternate file being overwritten with a :read command
    let cpoptions_save = &cpoptions
    set cpoptions-=a
    exe 'read' path_to_skeletons
  finally
    let &cpoptions = cpoptions_save
  endtry
  1, 1 delete _
  let fname = expand('%:t')
  let fname = toupper(fname)
  let fname = substitute(fname, '\.', '_', 'g')
  %s/HEADERNAME/\=fname/g
  call search('^$')
endfunction

if line('$') == 1 && empty(getline(1)) && bufname('%') =~? '.h$'
  call <sid>insertCHHeader()
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
inoremap <buffer> ( ()<c-g>U<left>
inoremap <buffer> [ []<c-g>U<left>
inoremap <buffer> { {}<c-g>U<left>

inoremap <buffer> <expr> ) getline('.')[col('.')-1]==')' ? '<c-g>U<right>' : ')'
inoremap <buffer> <expr> ] getline('.')[col('.')-1]==']' ? '<c-g>U<right>' : ']'
inoremap <buffer> <expr> > getline('.')[col('.')-1]=='>' ? '<c-g>U<right>' : '>'
inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'
inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'

inoremap <buffer> " ""<c-g>U<left>
inoremap <buffer> ' ''<c-g>U<left>
inoremap <buffer> ` ``<c-g>U<left>

" brackets around paragraph
nnoremap <buffer> <leader>{} mz{S{<esc>}S}<esc>=%`z=iB
nnoremap <buffer> <leader>{{ o}<esc>kO{<esc>3==j

" semicolon/coma EOL toggle
nnoremap <buffer> <expr> <leader>; getline('.')[col('$') - 2] == ';' ? 'mz$x`z' : 'mzA;\<esc>`z'
nnoremap <buffer> <expr> <leader>, getline('.')[col('$') - 2] == ',' ? 'mz$x`z' : 'mzA,\<esc>`z'

"  name of current c,cpp function (needs '()')
nnoremap <buffer> <silent> g<c-d> ][[[h^t(b

" select all text in function
nnoremap <buffer> <leader>vf j[[V%o

" make
nnoremap <leader>ce :VShell make test<cr>
nnoremap <leader>ct :VShell make test TESTFF=test/test*<cr>
nnoremap <leader>cT :VShell make test TESTFF=
nnoremap <leader>cb :VShell bear make<cr>
nnoremap <leader>cn :exe 'Shell norminette.rb' expand('%:p')<cr>
nnoremap <leader>cN :exe 'Shell norminette.rb' expand('.')<cr>

" debug
nnoremap <leader>cv :VShell make valgrind<cr>
nnoremap <leader>cg :tabnew<bar>Termdebug<cr>
nmap <leader>cn <plug>(NorminetteFile)
nmap <leader>cN <plug>(NorminetteFolder)
