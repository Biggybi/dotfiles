if exists('g:plugin_yankglobalsearch')
  finish
endif
let g:plugin_yankglobalsearch = 1

function! s:yankGlobalSearch(reg = '') abort
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '"' : a:reg
  if ! empty(hits)
    execute 'let @'.reg.' = join(hits, "\n") . "\n"'
  else
    echohl WarningMsg
    echo "Pattern not found:" @/
    echohl None
  endif
endfunction

command! -register YankGlobalSearch call s:yankGlobalSearch(<q-reg>)
nnoremap <expr> <plug>YankGlobalSearch <sid>yankGlobalSearch(v:register)
if !hasmapto('<plug>YankGlobalSearch') && maparg('ygs', 'n') ==# ''
  nmap ygs <plug>YankGlobalSearch()
endif
