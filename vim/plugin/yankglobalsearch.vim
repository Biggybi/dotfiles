if exists('g:plugin_yankglobalsearch')
  finish
endif
let g:plugin_yankglobalsearch = 1

function! s:yankGlobalSearch(reg)
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

command! -register CopyMatches call s:yankGlobalSearch(<q-reg>)
nnoremap <expr> <plug>CopyMatches <sid>yankGlobalSearch()
if !hasmapto('<plug>CopyMatches') && maparg('gp', 'n') ==# ''
  nmap ygs <plug>CopyMatches
endif
