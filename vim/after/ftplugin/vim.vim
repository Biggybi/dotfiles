setlocal tabstop=2
setlocal expandtab
setlocal textwidth=0
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal keywordprg=:help

nnoremap <leader>s. mz:source %<cr>:nohlsearch<cr>
nnoremap <buffer> <silent> zM :setlocal foldlevel=0<cr>zm100<c-y>
inoremap <buffer> ,""<space> ""<space><space><space><space>
inoremap <buffer> ,"""<space> """<space><space><space><space><space><space><space><space>
inoremap <buffer> ,''<space> ""<space><space><space><space>
inoremap <buffer> ,'''<space> """<space><space><space><space><space><space><space><space>
