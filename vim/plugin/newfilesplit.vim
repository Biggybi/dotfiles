if exists('g:plugin_newfilesplit')
  finish
endif
let g:plugin_newfilesplit = 1

let g:newfilesplit_hometild = get(g:, 'newfilesplit_hometild', 1)
let g:newfilesplit_base_map = get(g:, 'newfilesplit_base_map', "<c-n>")

function! s:fPath(hometild = 2) abort
  let fpath=expand('%:p:h').'/'
  if a:hometild == 0
    return fpath
  endif
  if a:hometild == 1 || g:newfilesplit_hometild == 1
    return substitute(fpath, '^'.$HOME, '~', '')
  endif
  return fpath
endfunction

" Note: Fix: command not showing in command-line until input
nnoremap <expr> <plug>NewFile    ":e "    . <sid>fPath()
nnoremap <expr> <plug>NewFileVer ":vs "   . <sid>fPath()
nnoremap <expr> <plug>NewFileHor ":sp "   . <sid>fPath()
nnoremap <expr> <plug>NewFileTab ":tabe " . <sid>fPath()

function! s:map(mapstring, type)
  if maparg(g:newfilesplit_base_map.a:mapstring, 'n') ==# ''
    exe printf("nmap %s%s <Plug>NewFile%s", g:newfilesplit_base_map, a:mapstring, a:type)
  endif
endfunction

if !hasmapto('<plug>NewFile')
  call s:map('n',     '<right>')
  call s:map('<c-n>', '<right>')
  call s:map('v',     'Ver')
  call s:map('<c-v>', 'Ver')
  call s:map('s',     'Hor')
  call s:map('<c-s>', 'Hor')
  call s:map('t',     'Tab')
  call s:map('<c-t>', 'Tab')
endif
