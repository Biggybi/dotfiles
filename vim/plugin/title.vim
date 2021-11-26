if exists('g:plugin_title')
  finish
endif
let g:plugin_title = 1

augroup WinTitle
  au!
  au BufRead,BufEnter * call s:mywindowTitle()
augroup end

function! s:getGitRepoName(file) abort
  let path=fnamemodify(a:file, ':p')
  while path != '' && path != '/'
    let path=fnamemodify(path, ':h')
    let folder=substitute(path, '/.*/', '', '')
    if isdirectory(path . '/.git')
      return folder
    endif
  endwhile
  return ''
endfunction

function! s:mywindowTitle() abort
  let hostname = hostname()
  let progname = v:progname
  let gitrepo  = s:getGitRepoName('%')
  let filename = substitute(expand('%'), '.*/', '', '')
  let &titlestring = printf('%s | %s | %s 〉%s',
        \ hostname, progname, gitrepo, filename)
endfunction
