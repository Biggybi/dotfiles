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

function! s:statusLineStartUp() abort
  setlocal statusline =
  setlocal statusline +=%1*\ %-2{g:currentmode[mode()]}%*  " mode
  setlocal statusline +=%4*%r%h%w%*\                       " read only, special buffers
  setlocal statusline +=%3*%f%*%5*%m%*\%3*                 " filename[modified]
  setlocal statusline +=%=                                 " left/right separation
  setlocal statusline +=%{exists('g:anzu_topbottom_word')?
        \anzu#search_status():''}\ %*                      " search results
  setlocal statusline +=%2*%(\ %{&filetype}\ %)%*          " filetype
  setlocal statusline +=%1*%<\ %3p%%\                      " total (%)
  setlocal statusline +=%4l:                               " current line
  setlocal statusline +=%-4v%*                             " virtual column
endfunction

function! s:statusLineActive() abort
  setlocal statusline =
  setlocal statusline +=%1*\ %-2{g:currentmode[mode()]}%*  " mode
  if exists('g:loaded_fugitive') 
    if FugitiveHead() != ''
      setlocal statusline +=%2*\ %{FugitiveHead()}%*       " git branch
      setlocal statusline +=%4*%r%h%w                      " read only, special buffers
      setlocal statusline +=%{GitModify()}%*               " git modified
      setlocal statusline +=%6*\ %{
            \split(getcwd(),'/')[-1]}%*%3*\/%*             " git project
      setlocal statusline +=%3*%f%*                        " file name
    else
      setlocal statusline +=%4*%r%h%w%*\                   " read only, special buffers
      setlocal statusline +=%3*%F%*                        " file path/name
    endif
  else
    setlocal statusline +=%4*%r%h%w%*\                     " read only, special buffers
    setlocal statusline +=%3*%f%*                          " file name
  endif
  setlocal statusline +=%5*%m%*                            " file modified
  setlocal statusline +=%3*%=                              " left/right separation
  setlocal statusline +=%{exists('g:anzu_topbottom_word')?
        \anzu#search_status():''}\ %*                      " search results
  setlocal statusline +=%2*%(\ %{&filetype}\ %)%*          " filetype
  setlocal statusline +=%1*%<\ %3p%%\                      " total (%)
  setlocal statusline +=%4l:                               " current line
  setlocal statusline +=%-4v%*                             " virtual column
endfunction

function! s:statusLineInactive() abort
  setlocal statusline =
  if exists('g:loaded_fugitive') && FugitiveHead() != ''
    setlocal statusline +=%{index(['~','/'],expand('%F')[0])>0?
          \get(split(expand('%:p:h'),
          \split(getcwd(),'/')[-1]),'0',''):''}            " lhs
    setlocal statusline +=%6*%{
          \get(split(getcwd(),'/'),'-1','')}%*             " git project
    setlocal statusline +=%{
          \get(split(expand('%:p:h'),
          \split(getcwd(),'/')[-1]),'1','')}\/             " rhs
    setlocal statusline +=%t                               " filename
  else
    setlocal statusline +=%F                               " filename
  endif
  setlocal statusline +=%m                                 " file modified
  setlocal statusline +=%=%{&filetype}\                    " filetype
endfunction

augroup StatusActiveSwitch
  au!
  au VimEnter * ++once
        \ if bufname('%') == ''
        \| call s:statusLineStartUp()
        \|endif
  au BufEnter,WinEnter *
        \ call s:statusLineActive()
  au WinLeave *
        \ call s:statusLineInactive()
augroup end
