setlocal colorcolumn=81
setlocal suffixesadd=.bash,.sh

" easy shebang
inoremap <buffer> <expr> ! col('.') == 2 && getline('.') =~ "^#" ? "!/bin/bash" : "!"
inoremap <buffer> ,#! #!/bin/bash
imap foufou

" alias to function
nnoremap <buffer> <leader>xf ^dWf=2s() {<cr><esc>$x==o}<esc>

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
if ! empty('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
endif
let b:undo_ftplugin .= "setlocal colorcolumn< suffixesadd<"
