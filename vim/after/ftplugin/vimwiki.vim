setlocal norelativenumber
setlocal showbreak=
setlocal nobreakindent
setlocal linebreak

nnoremap <buffer> <leader>cr <Plug>(VimwikiToggleListItem)

let b:undo_ftplugin = get(b:, 'undo_ftplugin' .. ' | ', '')
let b:undo_ftplugin .= "setlocal number< relativenumber< showbreak< breakindent< linebreak<"
