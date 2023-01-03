setlocal colorcolumn=81
setlocal foldmethod=syntax
setlocal suffixesadd=.c,.h
setlocal path=inc,incs,includes,include,src,sources,source

" workaround for makefile: last line would link to a wrong file
setlocal errorformat^=,%Amake:\ ***\ [%f:%l:\ %.%#]%m

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

inoremap <buffer> ,ma <esc>:Header42<cr>iint<tab><tab>main(int ac, char **av)<cr>{<cr>}<esc>Oreturn(0);<esc>O
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
nnoremap <buffer> <leader>cc      :!gcc -Wall -Wextra % && ./a.out<cr>
nnoremap <buffer> <leader>cC      :!gcc -Wall -Wextra % && ./a.out<cr>
nnoremap <buffer> <leader>csc     :Shell gcc -Wall -Wextra % && ./a.out<cr>
nnoremap <buffer> <leader>cs<c-m> :Shell gcc -Wall -Wextra % main.c && ./a.out<cr>

inoremap <buffer> " ""<c-g>U<left>
inoremap <buffer> ' ''<c-g>U<left>
inoremap <buffer> ` ``<c-g>U<left>

" brackets around paragraph
nnoremap <buffer> <leader>{} mz{S{<esc>}S}<esc>=%`z=iB
nnoremap <buffer> <leader>{{ o}<esc>kO{<esc>3==j

" declaration of current function (needs '()')
nnoremap <buffer> <silent> <leader>gm ][[[h^t(b

" select all text in function
nnoremap <buffer> <leader>vf j[[V%o

" make
nnoremap <buffer> <leader>ce :VShell make ex<cr><cr>
nnoremap <buffer> <leader>ct :VShell make test TESTFF=test/test*<cr>
nnoremap <buffer> <leader>cT :VShell make test TESTFF=
nnoremap <buffer> <leader>cb :VShell make build<cr>
nnoremap <buffer> <leader>cn :exe 'Shell norminette.rb' expand('%:p')<cr>
nnoremap <buffer> <leader>cN :exe 'Shell norminette.rb' expand('.')<cr>

" debug
nnoremap <buffer> <leader>cv :VShell make valgrind<cr>
nnoremap <buffer> <leader>cg :tabnew<bar>Termdebug<cr>

" lsp
" switch to header file
if exists(":CocCommand")
  nnoremap <leader>hh :CocCommand clangd.switchSourceHeader<cr>
endif

nmap <buffer> <leader>cn <plug>(NorminetteFile)
nmap <buffer> <leader>cN <plug>(NorminetteFolder)

let b:undo_ftplugin = get(b:, 'undo_ftplugin' .. ' | ', '')
let b:undo_ftplugin .=  "setlocal colorcolumn< foldmethod< suffixesadd< path<"
