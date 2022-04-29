if exists('s:plugin_gittags')
  finish
endif
let s:plugin_gittags = 1

let s:tags_default = &tags

function! s:deleteTagFiles() abort
  call system("rm " .. join(s:tags_files_lst))
endfunction

function! s:getTagFiles() abort
  let s:tags_files_lst = systemlist('find .git -name "[0-9]*tags" 2> /dev/null')
endfunction

function! s:createTagFile()
  call system(".git/hooks/ctags >/dev/null 2>&1 &")
endfunction

function s:setTagOpt() abort
  call s:getTagFiles()
  let &tags = s:tags_default
  if ! len(s:tags_files_lst) | return | endif

  if &tags !=# '' && &tags['$'] !=# ','
    let &tags ..= ','
  endif
  let option_string = join(s:tags_files_lst, ',')
  let &tags ..= option_string
endfunction

function! s:ctags(...) abort
  if a:1 ==# '!'
    call s:deleteTagFiles()
  endif
  call s:createTagFile()
  call s:getTagFiles()
  call s:setTagOpt()
endfunction

call s:setTagOpt()

command! -bang Ctags call s:ctags(expand('<bang>'))
