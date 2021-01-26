function! s:insertDektopEntrySkel() abort
  try
    let path_to_skeletons = "$HOME/dotfiles/vim/skel/skel.desktop"
    " Save cpoptions
    let cpoptions = &cpoptions
    " Remove the 'a' option - prevents the name of the
    " alternate file being overwritten with a :read command
    exe "set cpoptions=" . substitute(cpoptions, "a", "", "g")
    exe "read " . path_to_skeletons
  finally
    " Restore cpoptions
    exe "set cpoptions=" . cpoptions
  endtry
  1, 1 delete _
  let fname = expand("%:t")
  let fname = substitute(fname, ".desktop$", "", "")
  let fname = substitute(fname, "\\.", "_", "g")
  %s/APPNAME/\=fname/g
  call search('Application')
endfunction

if line('$') == 1 && empty(getline(1)) && &filetype == "desktop"
  call <sid>insertDektopEntrySkel()
  call cursor('$', 0)
endif
