setlocal colorcolumn=81
setlocal suffixesadd=.js,.javascript,.es,.esx,.json
setlocal path+=javascript,tscript,typescript,js,ts,json

setlocal tabstop=2                   " visible width of tabs
setlocal softtabstop=2               " tabs 2 characters wide
setlocal shiftwidth=2                " indents 2 characters wide
setlocal expandtab                   " tabs break into spaces

nnoremap <buffer> <leader>cr :Run<cr>
nnoremap <buffer> <leader>ca :AutoRun<cr>
nnoremap <buffer> <leader>; i<c-o>mz<c-o>A;<esc>`z<esc>
nnoremap <buffer> <leader>, i<c-o>mz<c-o>A,<esc>`z<esc>
nnoremap <buffer> <leader>cc :Shell node %<cr>
nnoremap <buffer> <leader>ls :!live-server %<cr>

inoremap <buffer> ,if if ()<cr>{<cr>}<esc>2k3==f)i
inoremap <buffer> ,fo for ()<cr>{<cr>}<esc>2k3==f)i
inoremap <buffer> ,wh while ()<cr>{<cr>}<esc>2k3==f)i
inoremap <buffer> ,cl console.log();<esc>F)i
nnoremap <buffer> <leader>xl yiwoconsole.log();<esc>F(p
vnoremap <buffer> <leader>xl yoconsole.log();<esc>F(p

" auto close brackets
inoremap <buffer> ( ()<c-g>U<left>
inoremap <buffer> [ []<c-g>U<left>
inoremap <buffer> { {}<c-g>U<left>
inoremap <buffer> <expr> ) getline('.')[col('.')-1]==')' ? '<c-g>U<right>' : ')'
inoremap <buffer> <expr> ] getline('.')[col('.')-1]==']' ? '<c-g>U<right>' : ']'
inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'
inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'

let b:undo_ftplugin = get(b:, 'undo_ftplugin' .. ' | ', '')
let b:undo_ftplugin .= "setlocal colorcolumn< suffixesadd< path< tabstop< softtabstop< shiftwidth< expandtab<"
