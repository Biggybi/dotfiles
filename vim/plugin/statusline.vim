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
  return [a,m,r] == [0,0,0] ? '' : '[+]'
endfunction

function! GitStatus() abort
  let [a,m,r] = GitGutterGetHunkSummary()
  return join(['  [+'.a,'~'.m,'-'.r.']'])
endfunction

function! LongestLineLen() abort
  let len = max(map(range(1, line('$')), "virtcol([v:val, '$'])-1"))
  return len
endfunction

function! SLVirtualColumn() abort
  let cur = len(col('.'))
  let max = len(LongestLineLen())
  return col('.') . repeat(" ", max - cur)
endfunction

function! SLCurrentLine() abort
	let max = len(line('$'))
  let cur = len(line('.'))
  return repeat(" ", max - cur) . line('.')
endfunction

augroup StatusLineSwitch
  au!
  au InsertEnter * call ModeColor('StatusLineInsert')
  au WinEnter,BufWinEnter * call StatusLineActive()
  au WinLeave * call StatusLineInactive()
  au VimEnter,ColorScheme,InsertLeave *
        \ call SetStatusLineColorsAll()
augroup end

function! StatusLineBig() abort
  setlocal statusline =
  setlocal statusline +=%1*\ %-2{g:currentmode[mode()]}%*  "mode
  setlocal statusline +=%2*\ %{FugitiveHead()}             "git branch
  setlocal statusline +=%r%h%w                             "read only, special buffers
  setlocal statusline +=%{GitModify()}\ %*                 "git modified
  setlocal statusline +=%<                                 "cut filename from start
  setlocal statusline +=\ %f%m\ %*                         "filename[modified]
  setlocal statusline +=%=%2*%=\ %{&filetype}\ %*          "filetype
  setlocal statusline +=%1*\ \[%{SLCurrentLine()}\:        "current line
  setlocal statusline +=%4v\]             "virtual column
  setlocal statusline +=\ /\ [%L:                          "total lines
  setlocal statusline +=%2p%%\]\ %*                        "total (%)
  setlocal statusline +=%<                                 "cut at end
  return
endfunction

function! StatusLineActive() abort
  let f=expand("<afile>")
  if getfsize(f) > g:LargeFile || &filetype == 'help'
    call StatusLineBig()
    return 0
  endif
  setlocal statusline =
  setlocal statusline +=%1*\ %-2{g:currentmode[mode()]}%*  "mode
  setlocal statusline +=%2*\ %{FugitiveHead()}             "git branch
  setlocal statusline +=%r%h%w                             "read only, special buffers
  setlocal statusline +=%{GitModify()}\ %*                 "git modified
  setlocal statusline +=%<                                 "cut filename from start
  setlocal statusline +=\ %f%m\ %*                         "filename[modified]
  setlocal statusline +=%{anzu#search_status()}            "search results
  setlocal statusline +=%=%2*%=\ %{&filetype}\ %*          "filetype
  setlocal statusline +=%1*\ \[%{SLCurrentLine()}\:        "current line
  setlocal statusline +=%{SLVirtualColumn()}\]             "virtual column
  setlocal statusline +=\ /\ [%L:                          "total lines
  setlocal statusline +=%2p%%\]\ %*                        "total (%)
  setlocal statusline +=%<                                 "cut at end
endfunction

function! StatusLineInactive() abort
  setlocal statusline =
  setlocal statusline +=%f                                "filename
  setlocal statusline +=%{&modified?'[+]':''}             "file modified
  setlocal statusline +=%=%{&filetype}\                   "filetype
endfunction
