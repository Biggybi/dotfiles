setlocal colorcolumn=81
setlocal path+=inc,incs,includes,include,src,sources,source

function! s:insertMakefileSkel() abort
  try
    let skeleton = '$HOME/dotfiles/vim/skel/skel.makefile'
    " Remove the 'a' option - prevents the name of the
    " alternate file being overwritten with a :read command
    let cpoptions_save = &cpoptions
    set cpoptions-=a
    exe 'read' skeleton
  finally
    let &cpoptions = cpoptions_save
  endtry
  1, 1 delete _
  let file_path = expand('%:p:h')
  let parent_folder = substitute(file_path, '/.*/', '', '')
  let fname = substitute(parent_folder, '\.', '_', 'g')
  %s/PROGRAMNAME/\=fname/g
  call search(fname)
endfunction

if line('$') == 1 && empty(getline(1)) && &filetype == 'make'
  call <sid>insertMakefileSkel()
endif

" auto close brackets
inoremap <buffer> ( ()<c-g>U<left>
inoremap <buffer> $ $()<left>

let b:undo_ftplugin = get(b:, 'undo_ftplugin' .. ' | ', '')
let b:undo_ftplugin .= "setlocal colorcolumn< path<"
