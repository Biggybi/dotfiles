if exists('g:plugin_newfilesplit')
  finish
endif
let g:plugin_newfilesplit = 1

let g:newfilesplit_hometild = get(g:, 'newfilesplit_hometild', 1)

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
" nnoremap <plug>NewFile    :e <c-\>e<sid>fPath(1)<cr>
nnoremap <expr> <plug>NewFileVer ":vs "   . <sid>fPath()
nnoremap <expr> <plug>NewFileHor ":sp "   . <sid>fPath()
nnoremap <expr> <plug>NewFileTab ":tabe " . <sid>fPath()

" nnoremap <expr> <plug>NewFile <sid>newFile()
if !hasmapto('<plug>NewFile') && maparg('<c-n>', 'n') ==# ''
  nmap <c-n>n     <Plug>NewFile
  nmap <c-n><c-n> <Plug>NewFile
  nmap <c-n>v     <Plug>NewFileVer
  nmap <c-n><c-v> <Plug>NewFileVer
  nmap <c-n>s     <Plug>NewFileHor
  nmap <c-n><c-s> <Plug>NewFileHor
  nmap <c-n>t     <Plug>NewFileTab
endif
