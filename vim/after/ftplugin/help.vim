setlocal showbreak=
setlocal nonumber
setlocal signcolumn=no
setlocal wrap
setlocal keywordprg=:help
setlocal bufhidden=delete
setlocal conceallevel=0
setlocal winfixwidth

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
if ! empty('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
endif
let b:undo_ftplugin .= 'setlocal showbreak< number< signcolumn< wrap< keywordprg< bufhidden< conceallevel< winfixwidth<'
