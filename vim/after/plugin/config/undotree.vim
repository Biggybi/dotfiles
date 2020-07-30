if ! exists(':UndotreeShow')
  finish
endif

let g:undotree_SetFocusWhenToggle = 1

nnoremap you :UndotreeToggle<cr>
nnoremap [ou :UndotreeShow<cr>
nnoremap ]ou :UndotreeHide<cr>
nnoremap yo<c-u> :UndotreeFocus<cr>
