if exists('g:plugin_scratchterm')
  finish
endif
let g:plugin_scratchterm = 1

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>, 'J')
command! -complete=shellcmd -nargs=+ VShell call s:RunShellCommand(<q-args>, 'L')
function! s:RunShellCommand(cmdline, direction) abort
  if bufexists('scratch_terminal_output')
    bw! scratch_terminal_output
  endif
  let current_window = win_getid()
  wincmd v
  wincmd J
  if has("nvim")
    exe 'terminal '. a:cmdline
  else
    exe 'terminal ++curwin '. a:cmdline
  endif
  file scratch_terminal_output
  let term_window = win_getid()
  let term_buf_nr = buffer_number()
  if a:direction == 'L'
    wincmd L
  elseif a:direction == 'H'
    wincmd H
  elseif a:direction == 'J'
    wincmd J
    6 wincmd _
  elseif a:direction == 'K'
    wincmd K
    6 wincmd _
  endif
  if win_getid() != current_window
    call win_gotoid(current_window)
  endif
endfunction

function! MoveScrathTerm(direction) abort
  if bufexists('scratch_terminal_output')
    let current_window = win_getid()
    sbuffer scratch_terminal_output
    if a:direction == 'L'
      wincmd L
    elseif a:direction == 'H'
      wincmd H
    elseif a:direction == 'J'
      wincmd J
      6 wincmd _
    elseif a:direction == 'K'
      wincmd K
      6 wincmd _
    elseif a:direction == 'Q'
      :bw
    endif
    call win_gotoid(current_window)
  endif
endfunction

" Show terminal (like c-z), exit on any character
function! ShowTerm() abort
  silent !read -sN 1
  redraw!
endfunction
nnoremap [= :call ShowTerm()<cr>

" Show terminal (like c-z), exit on any character
function! ShowTerm() abort
  silent !read -sN 1
  redraw!
endfunction
nnoremap [= :call ShowTerm()<cr>

