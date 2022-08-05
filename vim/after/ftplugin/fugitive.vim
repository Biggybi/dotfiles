nmap <buffer> [h [c
nmap <buffer> ]h ]c
nmap <buffer> <c-j> ]]
nmap <buffer> <c-k> [[
nnoremap <silent> <buffer> <c-s> :e<cr>
setlocal nowrap

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
if ! empty('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
endif
let b:undo_ftplugin .= "setlocal wrap<"
