if ! exists('g:loaded_fugitive')
  finish
endif

nnoremap <silent> <leader>gg :vertical Git<cr>
set diffopt+=vertical " vertical split for diff

function! FugitiveBlameToggle() abort
  let current_window = win_getid()
  wincmd h
  if &ft ==? "fugitiveblame"
    wincmd q
  else
    call win_gotoid(current_window)
    :G blame
  endif
  call win_gotoid(current_window)
endfunction

nnoremap ghb :call FugitiveBlameToggle()<cr>
