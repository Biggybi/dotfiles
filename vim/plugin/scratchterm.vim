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

nnoremap <silent> <Plug>(ScrollScratchTermJ) :<c-u>call
      \ <sid>ScrollScratchTerm('J')<cr>
nnoremap <silent> <Plug>(ScrollScratchTermK) :<c-u>call
      \ <sid>ScrollScratchTerm('K')<cr>

nnoremap <silent> <Plug>(RunShellCommandRe) :<c-u>call
      \ <sid>RunShellCommand(g:Scratchterm_last_cmd, 'J')<cr>

" " Note: could replace these mappings with this? (does not trigger function)
" nnoremap <silent> <Plug>(MoveScratchTerm(direction)) :<c-u>call
"       \ <sid>MoveScratchTerm(direction)<cr>

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>, 'J')
command! -complete=shellcmd -nargs=+ VShell call s:RunShellCommand(<q-args>, 'L')

function! s:LaunchTerm(cmdline) abort
  if has("nvim")
    exe 'terminal '. a:cmdline
  else
    exe 'terminal ++curwin '. a:cmdline
  endif
  try
    file scratchterm
  catch /.*/
  endtry
  set signcolumn=no
endfunction

function! s:SetScratchAlternateFile(current_file) abort
  if a:current_file == ""
    return
  endif
  if @# =~ "\!.*"
    try
      bw! @#
    catch /.*/
    endtry
  endif
  let @# = a:current_file
endfunction

function! s:RunShellCommand(cmdline, direction) abort
  let g:Scratchterm_last_cmd = a:cmdline
  let cmdline = g:Scratchterm_last_cmd
  let currpath = getcwd()
  let current_file = bufname('%')
  let current_window = win_getid()
  let to_move = 1

  if bufexists('scratchterm') && bufwinid('scratchterm') != -1 " scratchterm in this tab
    sbuffer scratchterm
    enew " new window for easy cd
    exe "lcd!" currpath
    let to_move = 0
  elseif bufexists('scratchterm') && bufwinid('scratchterm') == -1  " scratchterm in another tab
    bw! scratchterm
    wincmd n
    wincmd J
  else                               " scratchterm nowhere
    wincmd n
    wincmd J
  endif
  call s:LaunchTerm(cmdline)
  call s:SetScratchAlternateFile(current_file)
  if to_move == 1
    call s:MoveScratchTerm(a:direction)
  endif
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

function! s:ScrollScratchTerm(direction) abort
  if !bufexists('scratchterm')
    return
  endif
  let current_window = win_getid()
  sbuffer scratchterm
  if (a:direction == "K")
    echo "coucou K"
    normal gg
  elseif (a:direction == "J")
    normal G
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

