if exists('g:plugin_insertundo')
  finish
endif
let g:plugin_insertundo = 1

let s:insert_break_undo_char = [
      \ '.',
      \ ',',
      \ ';',
      \ ':',
      \ "'",
      \ '"',
      \ '`',
      \ '(',
      \ ')',
      \ '{',
      \ '}',
      \ '[',
      \ ']',
      \ ]

function! s:create_i_map(char) abort
  if ! hasmapto(printf('i%s', a:char), 'i')
    execute printf('inoremap %s %s<c-g>u', a:char, a:char)
  endif
endfunction

for char in get(g:, 'insert_break_undo_char', s:insert_break_undo_char)
  call s:create_i_map(char)
endfor
