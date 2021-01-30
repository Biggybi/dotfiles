if exists('g:plugin_statusline')
  finish
endif
let g:plugin_statusline = 1

let g:currentmode={
      \ '__'     : '- ',
      \ 'c'      : 'C ',
      \ 'i'      : 'I ',
      \ 'ic'     : 'I ',
      \ 'ix'     : 'I ',
      \ 'n'      : 'N ',
      \ 'multi'  : 'M ',
      \ 'ni'     : 'N ',
      \ 'no'     : 'N ',
      \ 'R'      : 'R ',
      \ 'Rv'     : 'R ',
      \ 's'      : 'S ',
      \ 'S'      : 'S ',
      \ ''     : 'S ',
      \ 't'      : 'T ',
      \ 'v'      : 'V ',
      \ 'V'      : 'V ',
      \ ''     : 'V ',
      \}

function! GitModify() abort
  let [a,m,r] = GitGutterGetHunkSummary()
  return [a,m,r] == [0,0,0] ? ' ' : '[+]'
endfunction

function! s:statusLineActive() abort
  setlocal statusline =
  setlocal statusline +=%1*\ %-2{g:currentmode[mode()]}%*  " mode
  setlocal statusline +=%2*\ %{FugitiveHead()}%*           " git branch
  setlocal statusline +=%5*%r%h%w                          " read only, special buffers
  setlocal statusline +=%{GitModify()}%*\                  " git modified
  setlocal statusline +=\ %f%6*%m%*\                       " filename[modified]
  setlocal statusline +=%{anzu#search_status()}            " search results
  setlocal statusline +=%=%=%2*\ %{&filetype}\ %*          " filetype
  setlocal statusline +=%1*%<\ %3p%%\                        " total (%)
  setlocal statusline +=%4l:                               " current line
  setlocal statusline +=%-4v%*                             " virtual column
endfunction

function! s:statusLineInactive() abort
  setlocal statusline =
  setlocal statusline +=%f                                "filename
  setlocal statusline +=%m                                "file modified
  setlocal statusline +=%=%{&filetype}\                   "filetype
endfunction

augroup StatusActiveSwitch
  au!
  au WinEnter,BufWinEnter *
        \ call s:statusLineActive()
  au WinLeave *
        \ call s:statusLineInactive()
augroup end
