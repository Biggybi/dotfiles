setlocal textwidth=0
setlocal shiftwidth=2
setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
  " setlocal keywordprg=:help
setlocal suffixesadd=.vim

setlocal runtimepath+=~/.vim/after/plugin/config/
setlocal runtimepath+=~/.vim/after/ftplugin/
setlocal runtimepath+=~/.vim/plugin/config/
setlocal runtimepath+=~/.vim/plugin/
setlocal runtimepath+=~/.vim/colors/
setlocal runtimepath+=~/.vim/skel
setlocal runtimepath+=~/.vim/spell
" setlocal path+=~/.vim/

" Folding
setlocal foldmethod=expr
setlocal foldtext=VimFold()
setlocal foldexpr=getline(v\:lnum)=~'^\"\"'?'>'.(matchend(getline(v\:lnum),'\"\"*')-1)\:'='

nnoremap <buffer> <leader>s. :source %<bar>:filetype detect<cr>
nnoremap <buffer> <silent> zM :setlocal foldlevel=0<cr>zm100<c-y>
inoremap <buffer> ,""<space> ""<space><space><space><space>
inoremap <buffer> ,"""<space> """<space><space><space><space><space><space><space><space>
inoremap <buffer> ,''<space> ""<space><space><space><space>
inoremap <buffer> ,'''<space> """<space><space><space><space><space><space><space><space>

let b:undo_ftplugin = get(b:, 'undo_ftplugin' .. ' | ', '')
let b:undo_ftplugin .= "setlocal textwidth< shiftwidth< expandtab< tabstop< softtabstop< keywordprg< suffixesadd< runtimepath< path< foldmethod< foldtext< foldexpr< foldlevel<"
