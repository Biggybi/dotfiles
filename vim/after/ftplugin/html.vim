setlocal colorcolumn=81

if line('$') == 1 && empty(getline(1))
  0r $HOME/.vim/skel/html_header
  call search('^$')
endif

