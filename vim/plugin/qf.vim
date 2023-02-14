if exists('g:plugin_qff')
  finish
endif
let g:plugin_qff = 1

""    Encoding
augroup QfMakeConv
  au!
  au QuickfixCmdPost make call <sid>:qfMakeConv()
augroup END

" Change encoding of error file for quickfix
function! s:qfMakeConv() abort
  let qflist = getqflist()
  for i in qflist
    let i.text = iconv(i.text, "cp936", "utf-8")
  endfor
  call setqflist(qflist)
endfunction

""    Auto Open
augroup AutoQFOpen
  au!
  au QuickFixCmdPost [^l]* nested botright cwindow
  au QuickFixCmdPost    l* nested botright lwindow
augroup end

""    Toggle
" location list
nnoremap <expr> <leader>cl get(getloclist(0, {'winid':0}), 'winid', 0) ?
      \ ":lclose<cr>" : ":bot lopen<cr><c-w>p"

" quickfix list
nnoremap <expr> <leader>cq get(getqflist({'winid':1}), 'winid', 0) ?
      \ ":cclose<cr>" : ":bot copen<cr><c-w>p"

" current error
nnoremap <silent> <leader>cc :cc<cr>

""    Navigate
function! s:qfNavigation(next = 1) abort
  let navNext = a:next ? "cnext" : "cprev"
  let navLast = a:next ? "clast" : "cfirst"
  if empty(getqflist()) | echo "list empty" | return | endif
  try | silent! exe navNext | catch /.*/ | silent! exe navLast | endtry
endfunction

nnoremap <silent> ]q <cmd>call <sid>qfNavigation(1)<cr>
nnoremap <silent> [q <cmd>call <sid>qfNavigation(0)<cr>
