setlocal nonu
setlocal nornu
setlocal showbreak=
setlocal nobreakindent
setlocal linebreak

nnoremap <buffer> <leader>cr <Plug>(VimwikiToggleListItem)

let b:undo_ftplugin = "setlocal nu< rnu< showbreak< breakindent< linebreak<"
