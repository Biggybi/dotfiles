if exists('g:plugin_terminal')
  finish
endif
let g:plugin_terminal = 1

if ! has('nvim')
  augroup TermOpt
    au!
    au TerminalWinOpen * setlocal nonumber norelativenumber signcolumn=no
  augroup end
  finish
endif

augroup neovim_terminal
  au!
  au TermOpen  * startinsert
  au TermOpen  * setlocal nonumber norelativenumber signcolumn=no
  au TermOpen  * nnoremap <buffer> <c-c> i<c-c>
  au BufEnter  * if &buftype ==# 'terminal' | startinsert | endif
  au TermClose * execute 'bdelete! ' . expand('<abuf>')
augroup END
tnoremap <c-w> <c-\><c-n><c-w>
