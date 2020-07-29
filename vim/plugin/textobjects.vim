" Courtesy to DBK
if exists('g:textobjects')
  finish
endif
let g:textobjects = 1

"""        Start / End of line
onoremap h :<c-u>normal! ^<cr>
onoremap l :<c-u>normal! v$h<cr>
onoremap il :<c-u>normal! $v_<cr>

"""        Special char
let s:special_char = [
      \ '.',
      \ ',',
      \ ';',
      \ '?',
      \ '-',
      \ '_',
      \ '*',
      \ '\|',
      \ '/',
      \ '~',
      \ '!',
      \ '@',
      \ '#',
      \ '$',
      \ '%',
      \ '^',
      \ '&',
      \ ]

function! s:create_i_map(char) abort
  if ! hasmapto(printf('i%s', a:char), 'vo')
    execute printf('xnoremap <unique> i%s :<C-u>normal! T%svt%s<CR>',
          \ a:char, a:char, a:char)
    execute printf('onoremap <unique> i%s :<C-u>normal vi%s<CR>',
          \ a:char, a:char)
    execute printf('xnoremap <unique> in%s :<C-u>normal! f%slvt%s<CR>',
          \ a:char, a:char, a:char)
    execute printf('onoremap <unique> in%s :<C-u>normal vin%s<CR>',
          \ a:char, a:char)
    execute printf('xnoremap <unique> iN%s :<C-u>normal! F%shvT%s<CR>',
          \ a:char, a:char, a:char)
    execute printf('onoremap <unique> iN%s :<C-u>normal viN%s<CR>',
          \ a:char, a:char)
  endif
endfunction

function! s:create_a_map(char) abort
  if ! hasmapto(printf('a%s', a:char), 'vo')
    execute printf('xnoremap <unique> a%s :<C-u>normal! F%svf%s<CR>',
          \ a:char, a:char, a:char)
    execute printf('onoremap <unique> a%s :<C-u>normal va%s<CR>',
          \ a:char, a:char)
    execute printf('xnoremap <unique> an%s :<C-u>normal! f%svf%s<CR>',
          \ a:char, a:char, a:char)
    execute printf('onoremap <unique> an%s :<C-u>normal vin%s<CR>',
          \ a:char, a:char)
    execute printf('xnoremap <unique> aN%s :<C-u>normal! F%svF%s<CR>',
          \ a:char, a:char, a:char)
    execute printf('onoremap <unique> aN%s :<C-u>normal viN%s<CR>',
          \ a:char, a:char)
  endif
endfunction

for char in get(g:, 'special_char_obj', s:special_char)
  call s:create_i_map(char)
  call s:create_a_map(char)
endfor
