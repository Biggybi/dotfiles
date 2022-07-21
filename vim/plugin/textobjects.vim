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

function TextObject(rhs, bang) abort
  let o = ''
  " echo getpos('v')[2] getpos('.')[2]
  if getpos('v')[2] < getpos('.')[2] || getpos('v')[2] == 0
    let o = 'o'
    " exe "normal" .. a:bang 'o'
  endif
  exe "normal" .. a:bang o .. a:rhs
endfunction

function! s:map_i(lhs, rhsx, rhso) abort
  " echo a:lhs a:rhsx
  " echo a:lhs a:rhso
  " let x = s:rhs_parse(a:rhsx)
  " let o = a:rhs_parse(a:rhso)
  if ! hasmapto(a:lhs, 'x')
    " exe printf('xnoremap <silent> %s <cmd>normal! %s<CR>', a:lhs, a:rhsx)
    " exe printf('xnoremap <silent>  %s <cmd> normal! %s<CR>', a:lhs, a:rhsx)
    exe printf('xnoremap <silent> %s <cmd>call TextObject("%s", "!")<CR>', a:lhs, a:rhsx)
  endif
  if ! hasmapto(a:lhs, 'o')
    " exe printf('xnoremap <silent> %s <cmd>call TextObject("%s", "!")<CR>', a:lhs, a:rhsx)
    " exe printf('onoremap <silent> %s <cmd>normal %s<CR>', a:lhs, a:rhso)
    " exe printf('xnoremap <silent>  %s <cmd> normal %s<CR>', a:lhs, a:rhso)
    exe printf('onoremap <silent> %s <cmd>call TextObject("%s", "")<CR>', a:lhs, a:rhso)
  endif
endfunction

" let s:maps = []

function! s:create_special_i_map(char) abort
  let c = a:char
  call s:map_i('i' .. c,           'oT' .. c .. 'ot' .. c,    'vi' .. c)
  call s:map_i('i' ..  'n' .. c,   'f' .. c .. 'lo2t' .. c,   'vin' .. c)
  call s:map_i('i' .. 'N' .. c,    '%oF' .. c .. 'ho2T' .. c,   'viN' .. c)
  " call s:map_i('a' .. c,           'oF' .. c .. 'of' .. c,    'va' .. c)
  call s:map_i('a' .. c,           'F' .. c .. 'of' .. c,    'F' .. c .. 'of' .. c)
  call s:map_i('a' ..  'n' .. c,   'f' .. c .. 'lo2t' .. c,   'van' .. c)
  call s:map_i('a' .. 'N' .. c,    'F' .. c .. 'ho2T' .. c,   'vaN' .. c)
endfunction

function! s:create_special_a_map(char) abort
  if ! hasmapto(printf('a%s', a:char), 'xo')
    execute printf('xnoremap <silent> a%s :<c-u>normal! F%svf%s<CR>',
          \ a:char, a:char, a:char)
    execute printf('onoremap <silent> a%s :<c-u>normal va%s<CR>',
          \ a:char, a:char)
  endif
  if ! hasmapto(printf('an%s', a:char), 'xo')
    execute printf('xnoremap <silent> an%s :<c-u>normal! f%svf%s<CR>',
          \ a:char, a:char, a:char)
    execute printf('onoremap <silent> an%s :<c-u>normal vin%s<CR>',
          \ a:char, a:char)
  endif
  if ! hasmapto(printf('aN%s', a:char), 'xo')
    execute printf('xnoremap <silent> aN%s :<c-u>normal! F%svF%s<CR>',
          \ a:char, a:char, a:char)
    execute printf('onoremap <silent> aN%s :<c-u>normal viN%s<CR>',
          \ a:char, a:char)
  endif
endfunction

for char_pair in get(g:, 'special_char', s:special_char)
  call s:create_special_i_map(char_pair)
  " call s:create_special_a_map(char_pair)
endfor

"""        Bracket char in / iN / an / aN
if v:version > 800 && has('patch3255')
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
    if ! hasmapto(printf('i%s', char), 'xo')
      execute printf('xnoremap in%s :<c-u>normal! f%slvt%s%s<CR>',
            \ char, a:char1, a:char2, char == a:char1 ? 'o': '')
      execute printf('onoremap in%s :<c-u>normal f%slvt%s%s<CR>',
            \ char, a:char1, a:char2, char == a:char1 ? 'o': '')
      execute printf('xnoremap iN%s :<c-u>normal! F%shvT%s%s<CR>',
            \ char, a:char2, a:char1, char == a:char1 ? '': 'o')
      execute printf('onoremap iN%s :<c-u>normal F%shvT%s%s<CR>',
            \ char, a:char2, a:char1, char == a:char1 ? '': 'o')
    endif
  endfor
endfunction

function! s:create_bracket_a_map(char1, char2) abort
  for char in [a:char1, a:char2]
    if ! hasmapto(printf('a%s', char), 'xo')
      execute printf('xnoremap an%s :<c-u>normal! f%svf%s%s<CR>',
            \ char, a:char1, a:char2, char == a:char1 ? 'o': '')
      execute printf('onoremap an%s :<c-u>normal f%svf%s%s<CR>',
            \ char, a:char1, a:char2, char == a:char1 ? 'o': '')
      execute printf('xnoremap aN%s :<c-u>normal! F%svF%s%s<CR>',
            \ char, a:char2, a:char1, char == a:char1 ? '': 'o')
      execute printf('onoremap aN%s :<c-u>normal F%svF%s%s<CR>',
            \ char, a:char2, a:char1, char == a:char1 ? '': 'o')
    endif
  endfor
endfunction

for char_pair in get(g:, 'bracket_char', s:bracket_char)
  call s:create_bracket_i_map(char_pair[0], char_pair[1])
  call s:create_bracket_a_map(char_pair[0], char_pair[1])
endfor
