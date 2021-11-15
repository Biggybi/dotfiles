setlocal colorcolumn=81

" auto close brackets
inoremap <buffer> ( ()<c-g>U<left>
inoremap <buffer> [ []<c-g>U<left>
inoremap <buffer> { {}<c-g>U<left>

inoremap <buffer> <expr> ) getline('.')[col('.')-1]==')' ? '<c-g>U<right>' : ')'
inoremap <buffer> <expr> ] getline('.')[col('.')-1]==']' ? '<c-g>U<right>' : ']'
inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'
inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
if ! empty('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
endif
let b:undo_ftplugin .= "setlocal colorcolumn<"
