if exists('g:plugin_newfilesplit')
  finish
endif
let g:plugin_newfilesplit = 1

let g:newfilesplit_hometild = get(g:, 'newfilesplit_hometild', 1)
let g:newfilesplit_base_map = get(g:, 'newfilesplit_base_map', "<c-n>")

function! s:getPath(hometild_force = -1) abort
  let filepath = expand('%:p:h').'/'
  if a:hometild_force == 0
    return filepath
  endif
  if a:hometild_force == 1 || g:newfilesplit_hometild == 1
    let tildfpath = substitute(filepath, '^'.$HOME, '~', '')
    return tildfpath
  endif
  return filepath
endfunction

function s:fPathCur() abort
  return ":e ".s:getPath()
endfunction
function s:fPathVer() abort
  return ":vs ".s:getPath()
endfunction
function s:fPathHor() abort
  return ":sp ".s:getPath()
endfunction
function s:fPathTab() abort
  return ":tabnew ".s:getPath()
endfunction

nnoremap <expr> <plug>BufSplitCur <sid>fPathCur()
nnoremap <expr> <plug>BufSplitVer <sid>fPathVer()
nnoremap <expr> <plug>BufSplitHor <sid>fPathHor()
nnoremap <expr> <plug>BufSplitTab <sid>fPathTab()

function! s:map(mapstring, type)
  let lhs = g:newfilesplit_base_map.a:mapstring
  if maparg(lhs, 'n') ==# ''
    exe printf("nmap %s <Plug>BufSplit%s", lhs, a:type)
  endif
  let lhs = g:newfilesplit_base_map.'<c-'.a:mapstring.'>'
  if maparg(lhs, 'n') ==# ''
    exe printf("nmap %s <Plug>BufSplit%s", lhs, a:type)
  endif
endfunction

if !hasmapto('<plug>BufSplitCur') | call s:map('n', 'Cur') | endif
if !hasmapto('<plug>BufSplitVer') | call s:map('v', 'Ver') | endif
if !hasmapto('<plug>BufSplitHor') | call s:map('s', 'Hor') | endif
if !hasmapto('<plug>BufSplitTab') | call s:map('t', 'Tab') | endif
