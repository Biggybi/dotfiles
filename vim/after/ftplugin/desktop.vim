function! s:insertDektopEntrySkel() abort
  try
    let path_to_skeletons = '$HOME/dotfiles/vim/skel/skel.desktop'
    " Remove the 'a' option - prevents the name of the
    " alternate file being overwritten with a :read command
    let cpoptions_save = &cpoptions
    set cpoptions-=a
    exe 'read' path_to_skeletons
  finally
    let &cpoptions = cpoptions_save
  endtry
  1, 1 delete _
  let fname = expand('%:t')
  let fname = substitute(fname, '.desktop$', '', '')
  %s/APPNAME/\=fname/g
  call cursor(1, 1)
endfunction

if line('$') == 1 && empty(getline(1)) && &filetype == 'desktop'
  call <sid>insertDektopEntrySkel()
endif
