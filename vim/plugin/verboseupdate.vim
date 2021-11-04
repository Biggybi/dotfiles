if exists('g:plugin_verboseupdate')
  finish
endif
let g:plugin_verboseupdate = 1

" <c-s> save and enter normal mode
function! s:verboseUpdate() abort
  if &ro
    echo 'Error updating: '.expand('%') . ' (readonly)'
  else
    echo 'Updated ' . expand('%')
    silent write
  endif
endfunction

command! VerboseUpdate :call s:verboseUpdate()

if maparg('<c-s>', 'n') ==# ''
  nnoremap <c-s> :VerboseUpdate<cr>
endif
if maparg('<c-s>', 'v') ==# ''
  vnoremap <c-s> :<c-u>VerboseUpdate<cr>
endif
if maparg('<c-s>', 'i') ==# ''
  inoremap <c-s> <esc>:VerboseUpdate<cr>
endif

" nnoremap <expr> <plug>VerboseUpdate :VerboseUpdate<cr>
" nnoremap <expr> <plug>VerboseUpdate <sid>verboseUpdate()
" inoremap <expr> <plug>VerboseUpdate <sid>verboseUpdate()
" vnoremap <expr> <plug>VerboseUpdate <sid>verboseUpdate()

" if !hasmapto('<plug>VerboseUpdate') && maparg('<c-s>', 'n') ==# ''
"   nmap <c-s> <plug>VerboseUpdate
"   vmap <c-s> :<c-u><plug>VerboseUpdate
"   imap <c-s> <esc><plug>VerboseUpdate
" endif
