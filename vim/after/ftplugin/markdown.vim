setlocal linebreak
setlocal suffixesadd=.md

" Ignore diacritics/accents when searching
" cnoremap <buffer> <CR> <C-\>e getcmdtype() =~ '[?/]' ? substitute(getcmdline(), '\a', '[[=\0=]]', 'g'): getcmdline()<CR><CR>
" nnoremap <buffer> <leader>cr :Run<cr>
" nnoremap <buffer> <leader>ca :AutoRun<cr>
" nnoremap <buffer> <leader><cr> A<br><esc>

let b:undo_ftplugin .= "setlocal linebreak< suffixesadd<"
let b:undo_ftplugin = get(b:, 'undo_ftplugin' .. ' | ', '')
