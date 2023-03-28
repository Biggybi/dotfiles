if exists('g:plugin_eol_toggle_char')
  finish
endif
let g:plugin_eol_toggle_char = 1

" Toggle a char at end of line

let g:eol_toggle_char_map_prefix = get(g:, 'eol_toggle_char_map_prefix', 'ga')

function! s:ETC_Complete(...)
  return readfile(expand('%'))->map({->v:val[-1:]})->sort()->uniq()
endfunction

function! s:eolToggleChar(...)
  let c = a:0 ? a:1 : nr2char(getchar())
  if getline('.') =~# c .. '$'
    return getline('.')[:-2]
  else
    return getline('.') .. c
  endif
endfunction

function! s:eolToggleCharVisual(...)
  let c = a:0 ? a:1 : nr2char(getchar())
  if getline('.') =~# c .. '$'
    return getline('.')[:-2]
  else
    return getline('.') .. c
  endif
endfunction

command! -complete=customlist,<sid>ETC_Complete -nargs=*
      \ EolToggleChar :call setline('.', <sid>eolToggleChar(<f-args>))

nnoremap <plug>EolToggleChar <cmd>call setline('.', <sid>eolToggleChar())<cr>
xnoremap <plug>EolToggleChar <cmd>call setline('.', <sid>eolToggleCharVisual())<cr>
exe 'nnoremap' g:eol_toggle_char_map_prefix .. '<esc> <nop>'
exe 'xnoremap' g:eol_toggle_char_map_prefix .. '<esc> <nop>'

if !hasmapto('<plug>EolToggleChar') && maparg(g:eol_toggle_char_map_prefix, 'n') ==# ''
  exe 'nmap' g:eol_toggle_char_map_prefix '<plug>EolToggleChar'
endif
