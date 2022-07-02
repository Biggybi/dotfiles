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
  au BufLeave,WinLeave *
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
  elseif exists('*FugitiveGitDir()') && FugitiveGitDir() != ''
    setlocal statusline +=%2*%(\ %{FugitiveHead()}%)%*     " git branch
    setlocal statusline +=%4*%([%R]%)                      " read only, special buffers
    setlocal statusline +=%{GitModify()}%*                 " git modified
    setlocal statusline +=%(\ %w%q%)                       " special buffers
    setlocal statusline +=%7*%(\ %{FugitiveHead()!=''?
          \get(split(getcwd(),'/'),'-1','').'\ ':''}%)%*  " git project
    setlocal statusline +=%8*%(\ %{FugitiveHead()==''?
          \get(split(getcwd(),'/'),'-1','').'\ ':''}%)%*  " git submodule
    setlocal statusline +=%3*%<%(%{bufname()==''?'':
          \expand(bufname()).'\ '}%)%*                " file name
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
  endif
  if &buftype != 'help'                                    " help
    setlocal statusline +=\ %(%{%FilePath()%}%)              " file path
  endif
  setlocal statusline +=%5*\ %{&buftype!='terminal'?
        \&modified?'+\ ':'':''}%*                          " file modified
  setlocal statusline +=%=%(\ %{&filetype!=''?
        \&filetype:&buftype}\ %)                           " filetype or buftype
endfunction

function! FilePath() abort
  let focus_name = get(split(getcwd(), '/'), -1, '')
  let focus_gitdir = ''
  let focus_path = ''
  let unfoc_fullpath = ''
  let unfoc_gitdir = ''
  let unfoc_path_name = expand('%')
  if exists('g:loaded_fugitive')
    let focus_gitdir = FugitiveExtractGitDir('%')
    let focus_path = matchstr(focus_gitdir, ".*\\ze\\.git$")
  endif
  if exists('g:loaded_fugitive')
    let unfoc_gitdir = FugitiveExtractGitDir(unfoc_path_name)
    let unfoc_fullpath = FugitiveWorkTree(unfoc_gitdir)
  endif
  let unfoc_name = matchstr(unfoc_fullpath, "[^/]*$")
  let unfoc_relpath = matchstr(unfoc_fullpath, focus_path . "\\zs.*\\ze" . unfoc_name)
  let unfoc_filename = matchstr(unfoc_path_name, ".*" . unfoc_relpath . unfoc_name . "/\\zs.*")
  let unfoc_gitdir_path = matchstr(focus_gitdir, '.*\.git')
  let focus_gitdir_path = matchstr(unfoc_gitdir, '.*\.git')
  let unfoc_is_focsub = matchstr(focus_gitdir_path, unfoc_gitdir_path) != ''
  let unfoc_is_sub = match(unfoc_gitdir, '.*/.git/modules/.*') == 0
  if unfoc_is_focsub != 0
    if unfoc_is_sub " is a submodule of focused buffer
      if unfoc_name ==# focus_name
        return '%6*' . unfoc_name . '%3* ' . unfoc_path_name
      else
        return '%6*' . unfoc_name . '%3* ' . unfoc_filename
      endif
    else
      if unfoc_filename != ''
        return '%7*' . unfoc_name . '%3* ' . unfoc_filename
      else
        return '%7*' . unfoc_name . '%3* ' . unfoc_path_name
      endif
    endif
  endif
  if unfoc_gitdir != ''
    let unfoc_head = matchstr(unfoc_gitdir, '.*/\ze[^/]*/\.git')
    if unfoc_is_focsub == 0
      let unfoc_gitdir_path = matchstr(unfoc_gitdir, '.*\.git')
      let unfoc_parent_name = matchstr(unfoc_gitdir_path, '.*/\zs[^/]*\ze/\.git')
      if unfoc_is_sub
        if unfoc_relpath != ''
          return '%7*' . unfoc_parent_name . '%3* %6*' . unfoc_name . '%3* ' . unfoc_filename
        else
          return '%7*' . unfoc_parent_name . '%3* %6*' . unfoc_name . '%3* ' . unfoc_filename
        endif
      endif
      return '%7*' . unfoc_parent_name . '%3* ' . unfoc_filename
    else
      return unfoc_head . '%7*' . unfoc_name . '%3* ' . unfoc_filename
    endif
  endif
  return unfoc_path_name
endfunction

function! GitModify() abort
  if FugitiveHead() == ''  || &buftype == 'terminal'
    return ''
  endif
  let [a,m,r] = [0,0,0]
  if exists('*GitGutterGetHunkSummary')
    let [a,m,r] = GitGutterGetHunkSummary()
  elseif exists('b:gitsigns_status')
    let a = get(split(b:gitsigns_status), 0)
    let m = get(split(b:gitsigns_status), 1)
    let r = get(split(b:gitsigns_status), 2)
  endif
  return [a,m,r] == [0,0,0] ? ' ' : ' + '
endfunction
