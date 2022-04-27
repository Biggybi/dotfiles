if ! exists('g:loaded_anzu')
  finish
endif

let g:anzu_status_format = "[%i/%l]"
nnoremap <silent> yoh :call anzu#clear_search_status()<cr>:ToggleHL<cr>
