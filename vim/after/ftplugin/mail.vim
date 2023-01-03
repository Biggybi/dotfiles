setlocal linebreak
setlocal textwidth=0

let b:undo_ftplugin = get(b:, 'undo_ftplugin' .. ' | ', '')
let b:undo_ftplugin .= "setlocal linebreak< textwidth<"
