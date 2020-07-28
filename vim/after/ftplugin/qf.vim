setlocal colorcolumn=0 nolist nocursorline tw=0 norelativenumber showbreak=
" auto adjust height if not a vertical split (hopefuly)
au FileType qf
      \ if winheight('quickfix') + 3 < &lines
      \ |   call AdjustWindowHeight(1, 5)
      \ | endif
au QuickfixCmdPost make call QfMakeConv()

" vimscript is a joke
nnoremap <buffer> <cr> :execute "normal! \<lt>cr>"<cr>

nnoremap <buffer> j <c-n>
nnoremap <buffer> k <c-p>
