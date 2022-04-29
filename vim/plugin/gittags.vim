if exists('g:plugin_gittags')
  finish
endif
let g:plugin_gittags = 1

let tags_files_lst = systemlist('find .git -name "[0-9]*tags" 2> /dev/null')
let option_string = join(tags_files_lst, ',')[:-2]

if &tags ==# ''
  let &tags ..= ','
endif

let &tags ..= option_string

function! s:Ctags(...) abort
  " echo "coucou"
  " if a:0 ==# '!'
  "   exe ":!echo " .. join(tags_files_lst, ' ')
  " endif
  exe ":!.git/hooks/ctags >/dev/null 2>&1 &"
endfunction

command! -bang Ctags :call s:Ctags('<lt>bang>') | call feedkeys("\<c-m>", 't')
