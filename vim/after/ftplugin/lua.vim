setlocal textwidth=0
setlocal shiftwidth=2
setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
  " setlocal keywordprg=:help
setlocal suffixesadd=.lua

nnoremap <buffer> <leader>sr <cmd>source %<cr>

let b:undo_ftplugin = get(b:, 'undo_ftplugin' .. ' | ', '')
let b:undo_ftplugin .= "setlocal textwidth< shiftwidth< expandtab< tabstop< softtabstop< keywordprg< suffixesadd<"
