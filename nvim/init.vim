set runtimepath^=~/.vim
set runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Exclude some plugins
let g:loaded_fzf = 1
let g:loaded_airline = 1
let g:loaded_fzf_vim = 1
let g:plugin_tabline = 1
let g:plugin_statusline = 1
let g:plugin_modecolor = 1

source ~/.vim/vimrc
