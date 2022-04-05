setlocal colorcolumn=81
setlocal suffixesadd=.js,.javascript,.es,.esx,.json
setlocal path+=javascript,tscript,typescript,js,ts,json

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

" semicolon/coma EOL toggle
nnoremap <buffer> <expr> <leader>; getline('.')[col('$') - 2] == ';' ? "mz$x`z" : "mzA;\<esc>`z"
nnoremap <buffer> <expr> <leader>, getline('.')[col('$') - 2] == ',' ? "mz$x`z" : "mzA,\<esc>`z"

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
if ! empty('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
endif
let b:undo_ftplugin .= "setlocal colorcolumn< suffixesadd< path<"
