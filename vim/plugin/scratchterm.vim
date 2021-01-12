if exists('g:plugin_scratchterm')
  finish
endif
let g:plugin_scratchterm = 1

if exists('g:plugin_termtoggle') == 0
  let g:TermToggleHeight    = get(g:, 'TermToggleHeight', '6')
  let g:TermToggleWidth     = get(g:, 'TermToggleWidth', '50')
endif

let g:Scratchterm_last_cmd = get(g:, 'Scratchterm_last_cmd', 'ls -la')

nnoremap <silent> <Plug>(MoveScratchTermH) :<c-u>call
      \ <sid>MoveScratchTerm('H')<cr>
nnoremap <silent> <Plug>(MoveScratchTermJ) :<c-u>call
      \ <sid>MoveScratchTerm('J')<cr>
nnoremap <silent> <Plug>(MoveScratchTermK) :<c-u>call
      \ <sid>MoveScratchTerm('K')<cr>
nnoremap <silent> <Plug>(MoveScratchTermL) :<c-u>call
      \ <sid>MoveScratchTerm('L')<cr>
nnoremap <silent> <Plug>(MoveScratchTermQ) :<c-u>call
      \ <sid>MoveScratchTerm('q')<cr>
nnoremap <silent> <Plug>(RunShellCommandRe) :<c-u>call
      \ <sid>RunShellCommand(g:Scratchterm_last_cmd, 'J')<cr>

" Note: could replace these mappings with this? (does not trigger function)
nnoremap <silent> <Plug>(MoveScratchTerm(direction)) :<c-u>call
      \ <sid>MoveScratchTerm(direction)<cr>

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>, 'J')
command! -complete=shellcmd -nargs=+ VShell call s:RunShellCommand(<q-args>, 'L')

function! s:LaunchTerm(cmdline)
  if has("nvim")
    exe 'terminal '. a:cmdline
  else
    exe 'terminal ++curwin '. a:cmdline
  endif
  file scratchterm
endfunction

function! s:RunShellCommand(cmdline, direction) abort
  let g:Scratchterm_last_cmd = a:cmdline
  let cmdline = g:Scratchterm_last_cmd
  let current_window = win_getid()
  if bufexists('scratchterm') && bufwinid('scratchterm')
    sbuffer scratchterm
    enew
    Glcd
    call s:LaunchTerm(cmdline)
    if win_getid() != current_window
      call win_gotoid(current_window)
    endif
    return
  endif
  wincmd n
  wincmd J
  call s:LaunchTerm(cmdline)
  call s:MoveScratchTerm(a:direction)
  if win_getid() != current_window
    call win_gotoid(current_window)
  endif
endfunction

function! s:MoveScratchTerm(direction) abort
  if !bufexists('scratchterm')
    return
  endif
  let current_window = win_getid()
  sbuffer scratchterm
  execute "wincmd" a:direction
  if index(["H", "L"], a:direction) >= 0
    exe g:TermToggleWidth "wincmd |"
  elseif index(["J", "K"], a:direction) >= 0
    exe g:TermToggleHeight "wincmd _"
  endif
  call win_gotoid(current_window)
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

