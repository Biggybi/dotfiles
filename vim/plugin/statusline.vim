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

function! StatusLineActive() abort
  setlocal statusline =
  setlocal statusline +=%1*\ %-2{g:currentmode[mode()]}%*  " mode
  setlocal statusline +=%2*\ %{FugitiveHead()}             " git branch
  setlocal statusline +=%r%h%w                             " read only, special buffers
  setlocal statusline +=%{GitModify()}\ %*                 " git modified
  setlocal statusline +=\ %f%m\                            " filename[modified]
  setlocal statusline +=%{anzu#search_status()}            " search results
  setlocal statusline +=%=%=%2*\ %{&filetype}\ %*         c" filetype
  setlocal statusline +=%1*\ [\ %l:                        " current line
  setlocal statusline +=%-2v\]                             " virtual column
  setlocal statusline +=\/\[%L:                            " total lines
  setlocal statusline +=%2p%%\]\ %*                        " total (%)
  setlocal statusline +=%<                                 " cut at end
endfunction

function! StatusLineInactive() abort
  setlocal statusline =
  setlocal statusline +=%f                                "filename
  setlocal statusline +=%m                                "file modified
  setlocal statusline +=%=%{&filetype}\                   "filetype
endfunction
