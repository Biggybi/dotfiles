setlocal tabstop=8
setlocal showbreak=
setlocal nonumber
setlocal signcolumn=no
setlocal keywordprg=:Man

let b:undo_ftplugin = get(b:, 'undo_ftplugin' .. ' | ', '')
let b:undo_ftplugin .= "setlocal tabstop< showbreak< number< signcolumn< keywordprg<"
