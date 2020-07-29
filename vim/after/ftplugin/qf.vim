setlocal colorcolumn=0
setlocal nolist
setlocal nocursorline
setlocal tw=0
setlocal norelativenumber
setlocal showbreak=
setlocal wrap

" vimscript is a joke
nnoremap <buffer> <cr> :execute "normal! \<lt>cr>"<cr>

nnoremap <buffer> j <c-n>
nnoremap <buffer> k <c-p>

" auto adjust height if not a vertical split (hopefuly)
if winheight('quickfix') + 3 < &lines
  call AdjustWindowHeight(1, 5)
endif
