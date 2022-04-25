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
