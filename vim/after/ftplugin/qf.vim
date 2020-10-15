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

" Quickfix window height auto adjust if too big
function! s:adjustWindowHeight(minheight, maxheight)
  let l = 1
  let n_lines = 0
  let w_width = winwidth(0)
  while l <= line('$')
    " number to float for division
    let l_len = strlen(getline(l)) + 0.0
    let line_width = l_len/w_width
    let n_lines += float2nr(ceil(line_width))
    let l += 1
  endw
  exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" auto adjust height if not a vertical split (hopefuly)
if winheight('quickfix') < 5
  call s:adjustWindowHeight(3, 5)
endif
