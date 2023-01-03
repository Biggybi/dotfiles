setlocal viewoptions=

let b:undo_ftplugin = get(b:, 'undo_ftplugin' .. ' | ', '')
let b:undo_ftplugin .= "setlocal viewoptions<"
