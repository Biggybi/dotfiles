if exists('g:plugin_qff')
  finish
endif
let g:plugin_qff = 1

" augroup QfMakeConv
"   au!
"   au QuickfixCmdPost make call QfMakeConv()
" augroup END

" Change encoding of error file for quickfix
function! QfMakeConv() abort
  let qflist = getqflist()
  for i in qflist
    let i.text = iconv(i.text, "cp936", "utf-8")
  endfor
  call setqflist(qflist)
endfunction

augroup AutoQFOpen
  au!
  au QuickFixCmdPost [^l]* nested botright cwindow
  au QuickFixCmdPost    l* nested botright lwindow
augroup end
""    Navigate
function! s:qfNavigation(next = 1) abort
  let navNext = a:next ? "cnext" : "cprev"
  let navLast = a:next ? "clast" : "cfirst"
  echom navNext navLast
  if empty(getqflist()) | return | endif
  try | exe navNext | catch /.*/ | exe navLast | endtry
endfunction

nnoremap <silent> ]q :call <sid>qfNavigation(1)<cr>
nnoremap <silent> [q :call <sid>qfNavigation(0)<cr>
