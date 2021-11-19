setlocal textwidth=0
setlocal shiftwidth=2
setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
  " setlocal keywordprg=:help
setlocal suffixesadd=.lua

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
if ! empty('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
endif
let b:undo_ftplugin .= "setlocal textwidth< shiftwidth< expandtab< tabstop< softtabstop< keywordprg< suffixesadd<"
