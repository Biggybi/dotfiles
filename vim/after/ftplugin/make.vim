setlocal colorcolumn=81
setlocal path+=inc,incs,includes,include,src,sources,source

function! s:insertMakefileSkel() abort
  let path_to_skeletons = "$HOME/dotfiles/vim/skel/skel.makefile"
  " Save cpoptions
  let cpoptions = &cpoptions
  " Remove the 'a' option - prevents the name of the
  " alternate file being overwritten with a :read command
  exe "set cpoptions=" . substitute(cpoptions, "a", "", "g")
  exe "read " . path_to_skeletons
  " Restore cpoptions
  exe "set cpoptions=" . cpoptions
  1, 1 delete _
  let file_path = expand("%:p:h")
  let parent_folder = substitute(file_path, "/.*/", "", "")
  let fname = substitute(parent_folder, "\\.", "_", "g")
  %s/PROGRAMNAME/\=fname/g
  call search('Application')
endfunction

if line('$') == 1 && empty(getline(1)) && &filetype == "make"
  call <sid>insertMakefileSkel()
  call cursor('$', 0)
endif
