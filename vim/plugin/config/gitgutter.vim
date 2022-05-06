if exists('&signcolumn')        " Vim 7.4.2201
  if &signcolumn == 'no'
    set signcolumn=yes
  endif
else
  let g:gitgutter_sign_column_always = 1
endif
set updatetime=100              " need for Coc + gitgutter

let g:gitgutter_max_signs = 2000

let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '│'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '│'
