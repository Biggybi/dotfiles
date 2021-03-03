if exists('g:plugin_helpman')
  finish
endif
let g:plugin_helpman = 1

let g:ft_man_open_mode = 'vert'

augroup HelpManSplit
  au!
  au FileType man wincmd H
  au FileType help au! BufRead,BufEnter <buffer> silent!
        \ if winwidth(win_getid()) != 80
        \ |  :silent! wincmd H | :silent! 80 wincmd|
        \ |endif
  au FileType help
        \ let &scrolloff = &lines/10 + 1
  au FileType help au! BufLeave,WinLeave <buffer> silent!
        \ | if &columns < 100 | :silent! 0 wincmd| | endif
augroup end
