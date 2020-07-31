if exists('g:plugin_qf')
  finish
endif
let g:plugin_qf = 1

augroup QfMakeConv
  au!
  au QuickfixCmdPost make call QfMakeConv()
augroup END

" Change encoding of error file for quickfix
function! QfMakeConv() abort
  let qflist = getqflist()
  for i in qflist
    let i.text = iconv(i.text, "cp936", "utf-8")
  endfor
  call setqflist(qflist)
endfunction
