if exists('g:plugin_sourcer')
  finish
endif
let g:plugin_sourcer = 1

let g:sourcer_use_scriptease = get(g:, 'sourcer_use_scriptease', 1)

function! s:sourceScripts() abort
  let runtimecmd = exists(':Runtime') && g:sourcer_use_scriptease == 1
        \ ? 'Runtime'
        \ : 'runtime'
  let sources = split(&rtp, ',')
  let filters = [
        \"/\.vim/[^\/].*/start/",
        \"/\.vim/colors/",
        \"^/usr/",
        \"/ftplugin/",
        \"/skel",
        \"/spell",
        \]

  for filter in filters
    exe printf("call filter(sources, 'v:val !~ \"%s\"')", filter)
  endfor

  for source in sources
    silent! exe printf("%s %s/*.vim", runtimecmd, source)
  endfor
  if exists('$MYVIMRC') | source $MYVIMRC | endif
endfunction

nnoremap <expr> <plug>Sourcer <sid>sourceScripts() . ":echo 'Sourcer done'<cr>"

if !hasmapto('<Plug>Sourcer') && maparg('<leader>sp','n') ==# ''
    nmap <leader>sp <Plug>Sourcer
endif
