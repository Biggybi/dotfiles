if exists('g:plugin_sourcer')
  finish
endif
let g:plugin_sourcer = 1

let g:sourcer_use_scriptease = get(g:, 'sourcer_use_scriptease', '1')

function! s:sourceScripts() abort
  let runtimecmd = exists(':Runtime') && g:sourcer_use_scriptease == 1
        \ ? 'Runtime'
        \ : 'runtime'
  let sources = split(&rtp, ',')
  let filters = [
        \"/\.vim/[^\/].*/start/",
        \"/\.vim/colors/",
        \"^/usr",
        \"/ftplugin/"
        \]
  for filter in filters
    exe printf("call filter(sources, 'v:val !~ \"%s\"')", filter)
  endfor

  for source in sources
    exe printf("silent! %s %s*.vim", runtimecmd, source)
  endfor
endfunction

nnoremap <expr> <plug>Sourcer <sid>sourceScripts()

if !hasmapto('<Plug>Sourcer') && maparg('<leader>sp','n') ==# ''
    nmap <leader>sp <Plug>Sourcer
endif
