if exists('g:plugin_norminette')
  finish
endif
let g:plugin_norminette = 1

nnoremap <silent> <Plug>(NorminetteFile) :<c-u>call
      \ <sid>Norminette('%')<cr><cr>
nnoremap <silent> <Plug>(NorminetteFolder) :<c-u>call
      \ <sid>Norminette('**/*.[ch]')<cr><cr>

command! -complete=file_in_path -nargs=* Norminette call s:Norminette(<q-args>)

function! s:Norminette(...) abort
  try
    let l:errorformat_save = &errorformat
    let l:makeprg_save = &makeprg
    set makeprg=norminette.rb
    set errorformat=%EError\ (line\ %l\\,\ col\ %c):%m
    set errorformat+=,%EError\ (line\ %l):%m
    exe "make" a:1
  finally
    let &makeprg = l:makeprg_save
    let &errorformat = l:errorformat_save
  endtry
  endfunction

