if exists('g:plugin_scratchjob')
  finish
endif
let g:plugin_scratchjob = 1

command! -complete=shellcmd -nargs=+ Shell2 call s:TmpShellOutput(<q-args>)
function! s:TmpShellOutput(cmdline) abort
  if bufexists('tmplog')
    call deletebufline('tmplog', 1, '$')
  else
    call bufadd('tmplog')
    call setbufvar('tmplog', "buftype", "nofile")
    call setbufvar('tmplog', "filetype", "")
  endif
  " let logjob = job_start(execute("!bash " . a:cmdline),
  if has("nvim")
    let logjob = jobstart(["/bin/bash", "-c", a:cmdline],
          \ {'out_io': 'buffer', 'out_name': 'tmplog', 'out_msg': ''})
  else
    let logjob = job_start(["/bin/bash", "-c", a:cmdline],
          \ {'out_io': 'buffer', 'err_io': 'buffer', 'out_name': 'tmplog', 'err_name': 'tmplog', 'out_msg': ''})
  endif
  let winnr = win_getid()
  vert sbuffer tmplog
  setlocal wrap
  " nnoremap <buffer> <c-c> :call job_stop('logjob')<cr>
  wincmd L
  60 wincmd |
  if win_getid() != winnr
    call win_gotoid(winnr)
  endif
endfunction
