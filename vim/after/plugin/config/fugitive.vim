if ! exists('g:loaded_fugitive')
  finish
endif

set diffopt+=vertical " vertical split for diff

function! s:fugitiveBlameToggle() abort
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
command! FugitiveBlameToggle :call <sid>fugitiveBlameToggle()

nnoremap <silent> ghb :FugitiveBlameToggle<cr>
nnoremap <silent> <leader>gg :vertical Git<cr>
nnoremap <silent> ghg :vertical Git<cr>
nnoremap <silent> ghc :G commit<cr>
nnoremap <silent> ghl :Gclog<cr>
nnoremap <silent> ghp :G push<cr>
nnoremap <silent> ghr :Gread<cr>
nnoremap <silent> ghh :G add %<cr>
nnoremap <silent> gha :G commit --amend<cr>
nnoremap <silent> ghe :G commit --amend --no-edit<cr>
