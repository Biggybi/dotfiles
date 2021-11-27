if exists('g:plugin_statusline')
  finish
endif
let g:plugin_statusline = 1

let g:currentmode={
      \ '__'    : '-',
      \ 'c'     : 'C',
      \ 'i'     : 'I',
      \ 'ic'    : 'I',
      \ 'ix'    : 'I',
      \ 'n'     : 'N',
      \ 'multi' : 'M',
      \ 'ni'    : 'N',
      \ 'no'    : 'N',
      \ 'R'     : 'R',
      \ 'Rv'    : 'R',
      \ 's'     : 'S',
      \ 'S'     : 'S',
      \ ''    : 'S',
      \ 't'     : 'T',
      \ 'v'     : 'V',
      \ 'V'     : 'V',
      \ ''    : 'V',
      \ }

augroup StatusActiveSwitch
  au!
  au VimEnter * ++once
        \ if expand('<afile>') == ''
        \ |  call s:statusLineStartUp()
        \ |endif
  au BufEnter ?\+ ++once
        \ call s:statusLineActive()
  au WinEnter,BufEnter *
        \ if &ft !=# 'qf'
        \ |  call s:statusLineActive()
        \ |setlocal cursorline
        \ |endif
  au WinLeave *
        \ call s:statusLineInactive()
        \ |setlocal nocursorline
augroup end

function! s:statusLineStartUp() abort
  setlocal statusline =
  setlocal statusline +=%1*\ VIM\ %*
  setlocal statusline +=%=                                 " left/right separation
  setlocal statusline +=%1*\ Intro\ %*
endfunction

function! s:statusLineActive() abort
  setlocal statusline =
  setlocal statusline +=%1*\ %-2{g:currentmode[mode()]}%*  " mode
  if &buftype == 'help'                                    " help
    setlocal statusline +=%2*\ %h\ %*\ %t                  "  [Help] filename
  elseif &buftype == 'quickfix'                            " quickfix window
    setlocal statusline +=%2*\ [QuickFix]\ %*              "  [QuickFix] filename
  elseif &buftype == 'terminal'                            " terminal window
    setlocal statusline +=%2*\ [Term]\ %*\ %t              "  [Term] filename
  elseif &previewwindow==1                                 " preview window
    setlocal statusline +=%2*\ %w\ %*%3*\ %t%*\            "  [Preview] filename
  elseif exists('g:loaded_fugitive') && FugitiveGitDir() != ''
    setlocal statusline +=%2*%(\ %{FugitiveHead()}%)%*     " git branch
    setlocal statusline +=%4*%([%R]%)                      " read only, special buffers
    setlocal statusline +=%{GitModify()}%*                 " git modified
    setlocal statusline +=%(\ %w%q%)                       " special buffers
    setlocal statusline +=%7*%(\ %{FugitiveHead()!=''?
          \get(split(getcwd(),'/'),'-1',''):''}%)%*        " git project
    setlocal statusline +=%8*%(\ %{FugitiveHead()==''?
          \get(split(getcwd(),'/'),'-1',''):''}%)%*        " git submodule
    setlocal statusline +=%3*%<%(%{bufname()==''?'':
          \'\/'.expand(bufname()).'\ '}%)%*                " file name
  else
    setlocal statusline +=%3*%<\ %F%*                      " file name
  endif
  setlocal statusline +=%5*%{&buftype!='terminal'?
        \&modified?'\ +\ ':'':''}%*                        " file modified
  setlocal statusline +=%3*%=                              " left/right separation
  setlocal statusline +=%{exists('g:anzu_topbottom_word')?
        \anzu#search_status():''}\ %*                      " search results
  setlocal statusline +=%2*%(\ %{&filetype}\ %)%*          " filetype
  setlocal statusline +=%1*%<\ %3p%%                       " total (%)
  setlocal statusline +=\ %4l:                             " current line
  setlocal statusline +=%-4v%*                             " virtual column
endfunction

function! s:statusLineInactive() abort
  setlocal statusline =
  if &buftype == 'help'                                    " help
    setlocal statusline +=\ %h\ %t                         "  [Help] filename
  elseif &buftype == 'quickfix'                            " quickfix window
    setlocal statusline +=\ [QuickFix]                     "  [QuickFix] filename
  elseif &buftype == 'terminal'                            " terminal window
    setlocal statusline +=\ [Term]\ %t                     "  [Term] filename
  elseif &previewwindow==1                                 " preview window
    setlocal statusline +=\ %w\ %t                         "  [Preview] filename
  elseif exists('g:loaded_fugitive') && FugitiveGitDir() != ''
    setlocal statusline +=\ %(%{GitRelativePath()}%)       " lhs
    setlocal statusline +=%7*%{FugitiveHead()!=''?
          \get(split(getcwd(),'/'),'-1',''):''}%*          " git project
    setlocal statusline +=%8*%{FugitiveHead()==''?
          \get(split(getcwd(),'/'),'-1',''):''}%*          " git submodule
    setlocal statusline +=%{
          \matchstr(expand('%:~'),
          \split(getcwd(),'/')[-1].'\\\zs.*')}             " git filepath
  else
    setlocal statusline +=\ %f                             " filename relative
  endif
  setlocal statusline +=%5*\ %{&buftype!='terminal'?
        \&modified?'+\ ':'':''}%*                          " file modified
  setlocal statusline +=%=%(\ %{&filetype!=''?
        \&filetype:&buftype}\ %)                           " filetype or buftype
endfunction

function! GitRelativePath() abort
  let curdir = get(split(getcwd(), '/'), -1, '')
  let gitdir = FugitiveExtractGitDir('%')
  let project_name = get(split(gitdir, '/'), -2, '')
  if index(['~', '/'], expand('%f')[0]) > 0
    if matchstr(g:actual_curbuf, curdir) != ''
      return ''
    endif
    if gitdir =~ '\.git.*$' && project_name != curdir
      let sub_gitmain = matchstr(gitdir, '/[^/]*.*/\zs.*/\ze\.git')
      let sub_path = matchstr(getcwd(), sub_gitmain.'.*/')
      if sub_path != ''
        return sub_path
      endif
    endif
    return get(split(expand('%:~'), curdir), '')
  endif
  if gitdir =~ '.git$' && project_name != curdir
    let sub_parent = matchstr(getcwd(), project_name.'.*/')
    return sub_parent
  endif
  return ''
endfunction

function! GitModify() abort
  if FugitiveHead() == ''  || &buftype == 'terminal'
    return ''
  endif
  let [a, m, r] = [0, 0, 0]
  if exists('*GitGutterGetHunkSummary')
    let [a,m,r] = GitGutterGetHunkSummary()
  elseif exists('b:gitsigns_status')
    let a = get(split(b:gitsigns_status), 0)
    let m = get(split(b:gitsigns_status), 1)
    let r = get(split(b:gitsigns_status), 2)
  endif

  return [a,m,r] == [0,0,0] ? ' ' : ' + '
endfunction
