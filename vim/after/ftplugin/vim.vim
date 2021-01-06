setlocal tabstop=2
setlocal expandtab
setlocal textwidth=0
setlocal softtabstop=2
setlocal shiftwidth=2
" setlocal keywordprg=:help
setlocal suffixesadd=.vim
setlocal formatoptions-=cro  " no auto comment line

setlocal runtimepath+=~/.vim/after/plugin/config/
setlocal runtimepath+=~/.vim/after/ftplugin/
setlocal runtimepath+=~/.vim/plugin/config/
setlocal runtimepath+=~/.vim/plugin/
setlocal runtimepath+=~/.vim/colors/
setlocal runtimepath+=~/.vim/skel
setlocal runtimepath+=~/.vim/spell
" setlocal path+=~/.vim/

" Folding
setlocal expandtab
setlocal tw=0
setlocal ts=2
setlocal sts=2
setlocal shiftwidth=2
setlocal foldmethod=expr

" Personnal folding design
setlocal foldtext=VimFold()
setlocal foldexpr=getline(v\:lnum)=~'^\"\"'?'>'.(matchend(getline(v\:lnum),'\"\"*')-1)\:'='

nnoremap <leader>s. mz:source %<cr>:nohlsearch<cr>
nnoremap <buffer> <silent> zM :setlocal foldlevel=0<cr>zm100<c-y>
inoremap <buffer> ,""<space> ""<space><space><space><space>
inoremap <buffer> ,"""<space> """<space><space><space><space><space><space><space><space>
inoremap <buffer> ,''<space> ""<space><space><space><space>
inoremap <buffer> ,'''<space> """<space><space><space><space><space><space><space><space>
