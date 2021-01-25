if exists('g:plugin_norminette')
  finish
endif
let g:plugin_norminette = 1

nnoremap <silent> <Plug>(NorminetteFile) :<c-u>call
      \ <sid>Norminette('%')<cr><cr>
nnoremap <silent> <Plug>(NorminetteFolder) :<c-u>call
      \ <sid>Norminette(expand(join(map(split(&path, ','), ' v:val . expand("/*.[ch]")'))))<cr><cr>

command! -complete=file_in_path -nargs=* Norminette call s:Norminette(<q-args>)

function! s:Norminette(...) abort
  try
    let l:errorformat_save = &errorformat
    let l:makeprg_save = &makeprg
    let l:current_window = win_getid()
    setlocal makeprg=norminette.rb\ -R\
          \CheckTopCommentHeader\,
          \CheckCommentsPlacement\,
          \CheckCommentsFormat\,
          \CheckCppComment\,
          \CheckForbiddenSourceHeader
    setlocal errorformat=%+PNorme:\ %f
    setlocal errorformat+=,%AError\ (line\ %l\\,\ col\ %c):%m
    setlocal errorformat+=,%AError\ (line\ %l):%m
    setlocal errorformat+=,%AWarning:%m
    exe "make" a:1
    botright copen
    if win_getid() != l:current_window
      call win_gotoid(l:current_window)
    endif
  finally
    let &makeprg = l:makeprg_save
    let &errorformat = l:errorformat_save
  endtry
endfunction
