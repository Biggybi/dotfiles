if exists('g:plugin_textobjects')
  finish
endif
let g:plugin_textobjects = 1

" Courtesy of DBK
" https://github.com/benknoble/Dotfiles/blob/master/links/vim/plugin/punctuation_textobjects.vim

"""        Whole Buffer
onoremap <silent> ag <cmd>keepjumps \| normal! ggVG<cr><c-o>

"""        Start / End of line
onoremap <silent> h  <cmd>normal! ^<cr>
onoremap <silent> l  <cmd>normal! v$h<cr>
onoremap <silent> il <cmd>normal! g_v_<cr>
onoremap <silent> al <cmd>normal! $v0<cr>
xnoremap <silent> il <cmd>normal! g_v_<cr>
xnoremap <silent> al <cmd>normal! $v0<cr>

"""        Special char i / in / iN / a / an / aN
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

function! s:create_special_i_map(char) abort
  if ! hasmapto(printf('i%s', a:char), 'vo')
    execute printf('xnoremap i%s :<C-u>normal! T%svt%s<CR>',
          \ a:char, a:char, a:char)
    execute printf('onoremap i%s :<C-u>normal vi%s<CR>',
          \ a:char, a:char)
  endif
  if ! hasmapto(printf('in%s', a:char), 'vo')
    execute printf('xnoremap in%s :<C-u>normal! f%slvt%s<CR>',
          \ a:char, a:char, a:char)
    execute printf('onoremap in%s :<C-u>normal vin%s<CR>',
          \ a:char, a:char)
  endif
  if ! hasmapto(printf('iN%s', a:char), 'vo')
    execute printf('xnoremap iN%s :<C-u>normal! F%shvT%s<CR>',
          \ a:char, a:char, a:char)
    execute printf('onoremap iN%s :<C-u>normal viN%s<CR>',
          \ a:char, a:char)
  endif
endfunction

function! s:create_special_a_map(char) abort
  if ! hasmapto(printf('a%s', a:char), 'vo')
    execute printf('xnoremap a%s :<C-u>normal! F%svf%s<CR>',
          \ a:char, a:char, a:char)
    execute printf('onoremap a%s :<C-u>normal va%s<CR>',
          \ a:char, a:char)
  endif
  if ! hasmapto(printf('an%s', a:char), 'vo')
    execute printf('xnoremap an%s :<C-u>normal! f%svf%s<CR>',
          \ a:char, a:char, a:char)
    execute printf('onoremap an%s :<C-u>normal vin%s<CR>',
          \ a:char, a:char)
  endif
  if ! hasmapto(printf('aN%s', a:char), 'vo')
    execute printf('xnoremap aN%s :<C-u>normal! F%svF%s<CR>',
          \ a:char, a:char, a:char)
    execute printf('onoremap aN%s :<C-u>normal viN%s<CR>',
          \ a:char, a:char)
  endif
endfunction

for char_pair in get(g:, 'special_char', s:special_char)
  call s:create_special_i_map(char_pair)
  call s:create_special_a_map(char_pair)
endfor

"""        Bracket char in / iN / an / aN
if has('patch3255')
  " this was implemented in path 3255
  finish
endif

  let s:bracket_char = [
        \ [ '(', ')' ],
        \ [ '{', '}' ],
        \ [ '<', '>' ],
        \ [ '[', ']' ],
        \ ]

function! s:create_bracket_i_map(char1, char2) abort
  for char in [a:char1, a:char2]
    if ! hasmapto(printf('i%s', char), 'vo')
      execute printf('xnoremap in%s :<C-u>normal! f%slvt%s%s<CR>',
            \ char, a:char1, a:char2, char == a:char1 ? 'o': '')
      execute printf('onoremap in%s :<C-u>normal f%slvt%s%s<CR>',
            \ char, a:char1, a:char2, char == a:char1 ? 'o': '')
      execute printf('xnoremap iN%s :<C-u>normal! F%shvT%s%s<CR>',
            \ char, a:char2, a:char1, char == a:char1 ? '': 'o')
      execute printf('onoremap iN%s :<C-u>normal F%shvT%s%s<CR>',
            \ char, a:char2, a:char1, char == a:char1 ? '': 'o')
    endif
  endfor
endfunction

function! s:create_bracket_a_map(char1, char2) abort
  for char in [a:char1, a:char2]
    if ! hasmapto(printf('a%s', char), 'vo')
      execute printf('xnoremap an%s :<C-u>normal! f%svf%s%s<CR>',
            \ char, a:char1, a:char2, char == a:char1 ? 'o': '')
      execute printf('onoremap an%s :<C-u>normal f%svf%s%s<CR>',
            \ char, a:char1, a:char2, char == a:char1 ? 'o': '')
      execute printf('xnoremap aN%s :<C-u>normal! F%svF%s%s<CR>',
            \ char, a:char2, a:char1, char == a:char1 ? '': 'o')
      execute printf('onoremap aN%s :<C-u>normal F%svF%s%s<CR>',
            \ char, a:char2, a:char1, char == a:char1 ? '': 'o')
    endif
  endfor
endfunction

for char_pair in get(g:, 'bracket_char', s:bracket_char)
  call s:create_bracket_i_map(char_pair[0], char_pair[1])
  call s:create_bracket_a_map(char_pair[0], char_pair[1])
endfor
