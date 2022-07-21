if exists('g:plugin_terminal')
  finish
endif
let g:plugin_terminal = 1

if ! has('nvim')
  augroup TermOpt
    au!
    au TerminalWinOpen * setlocal nonumber signcolumn=no
  augroup end
  finish
endif

augroup neovim_terminal
  au!
  au TermOpen * startinsert
  au TermOpen * :set nonumber norelativenumber
  au TermOpen * nnoremap <buffer> <c-c> i<c-c>
  au BufEnter * if &buftype ==# 'terminal' | startinsert | endif
  autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')
  " au TermOpen * tnoremap <buffer> <c-w> <c-\><c-n><c-w>
  " au TermOpen * tnoremap <buffer> <c-d> <c-d><cr><cr>
augroup END
tnoremap <c-d> <c-d><cr><cr>
tnoremap <c-w> <c-\><c-n><c-w>
