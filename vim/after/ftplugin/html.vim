setlocal colorcolumn=81

if line('$') == 1 && empty(getline(1)) && &filetype == "html"
  0r $HOME/.vim/skel/skel.html
  call cursor(search('^$'), 0)
endif

let b:undo_ftplugin = "setlocal colorcolumn<"
