if exists('g:plugin_norminette')
  finish
endif
let g:plugin_norminette = 1

let g:norminette_version = get(g:, 'norminette_version', '2')

nnoremap <silent> <Plug>(NorminetteFile) :<c-u>call
      \ <sid>Norminette('%')<cr><cr>
nnoremap <silent> <Plug>(NorminetteFolder) :<c-u>call
      \ <sid>Norminette()<cr><cr>

command! -complete=file -nargs=* Norminette call s:Norminette(<q-args>)

function s:norminetteV1() abort
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
endfunction

function s:norminetteV2() abort
    setlocal makeprg=norminette
    setlocal errorformat=%+P%f:%*\\sKO!
    setlocal errorformat+=,%A%*\\s%*\\p(line:%*\\s%l\\,%*\\scol:%*\\s%c):%m
endfunction

function! s:Norminette(...) abort
  try
    let l:errorformat_save = &errorformat
    let l:makeprg_save = &makeprg
    let l:current_window = win_getid()

    if g:norminette_version == 1
      call s:norminetteV1()
    elseif g:norminette_version == 2
      call s:norminetteV2()
    else
      echom "Norminette: version not supported: ". g:norminette_version
      return
    endif

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
