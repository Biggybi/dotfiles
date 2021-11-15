setlocal colorcolumn=81

if line('$') == 1 && empty(getline(1))
  0r $HOME/.vim/skel/bash_header
  normal! G
endif

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
if ! empty('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
endif
let b:undo_ftplugin .= "setlocal colorcolumn<"
