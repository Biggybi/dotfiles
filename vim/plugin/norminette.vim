if exists('g:plugin_norminette')
  finish
endif
let g:plugin_norminette = 1

nnoremap <silent> <Plug>(NorminetteFile) :<c-u>call
      \ <sid>Norminette('%')<cr><cr>
nnoremap <silent> <Plug>(NorminetteFolder) :<c-u>call
      \ <sid>Norminette()<cr><cr>

command! -complete=file -nargs=* Norminette call s:Norminette(<q-args>)

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

    " " norminette v2
    " setlocal errorformat=%+P%f:\ KO\!
    " setlocal errorformat+=,%A%*\\p(line:%*[\ ]%l\\,\ col:%*[\ ]%c):%m

    if a:0 == 0
      echom "no args"
      let files = system('find . -maxdepth 2 -type f -name "*.[ch]"')
    else
      let files = join(a:000)
    endif
    exe "make" files
    botright copen
    if win_getid() != l:current_window
      call win_gotoid(l:current_window)
    endif
  finally
    let &makeprg = l:makeprg_save
    let &errorformat = l:errorformat_save
  endtry
endfunction
