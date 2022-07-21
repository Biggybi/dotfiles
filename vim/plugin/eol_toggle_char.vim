if exists('g:plugin_eol_toggle_char')
  finish
endif
let g:plugin_eol_toggle_char = 1

" Toggle a char at end of line

function! s:ETC_Complete(...)
  return readfile(expand('%'))->map({->v:val[-1:]})->sort()->uniq()
endfunction

function! s:eolToggleChar(...)
  echo expand("'[") expand("']")
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

if !hasmapto('<plug>EolToggleChar') && maparg('ga', 'n') ==# ''
  nmap ga <plug>EolToggleChar
endif
