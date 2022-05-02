if ! exists(':CocEnable')
  finish
endif

""    edit config mappings
nnoremap <leader>eo :CocConfig<cr>
nnoremap <leader>Eo :split <bar> CocConfig<cr>
nnoremap <leader><c-e>o :vertical split <bar> CocConfig<cr>

""    pmenu mappings
if has("nvim")
  inoremap <expr> <c-space> pumvisible() ? coc#_select_confirm() : coc#refresh()
else
  inoremap <expr> <c-@> pumvisible() ? coc#_select_confirm() : coc#refresh()
endif

if has('nvim-0.4.0') || has('patch-8.2.0750')
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ?
        \ "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ?
        \ coc#float#scroll(1) : "\<C-f><cmd>call NoScrollAtEOF()\<cr>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ?
        \ coc#float#scroll(1) : "\<C-f>"

  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ?
        \ coc#float#scroll(0) : "\<C-b>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ?
        \ coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ?
        \ "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

  nnoremap <silent><nowait><expr> <C-]> coc#float#has_scroll() ?
        \ coc#float#close('.') : "\<C-]>"
  vnoremap <silent><nowait><expr> <C-]> coc#float#has_scroll() ?
        \ coc#float#close('.') : "\<C-]>"
  inoremap <silent><nowait><expr> <C-]> coc#float#has_scroll() ?
        \ "\<c-o>:call coc#float#close('.')\<cr>" : "\<C-]>"
endif

inoremap <silent> <expr> <c-j> pumvisible() ? "\<C-n>" : coc#refresh()
inoremap <silent> <expr> <c-k> pumvisible() ? "\<C-p>" : coc#refresh()
hi link CocHilightText Visual

""    snippets mappings

" inoremap <expr> <c-n> pumvisible() ? "\<C-p>" : coc#refresh()
let g:coc_snippet_next = '<c-f>'
let g:coc_snippet_prev = '<c-b>'

augroup CocJumpPlaceholder
  au!
  au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

""    function / class text object
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

""    lsp mappings
nmap <silent> <leader>gf <Plug>(coc-definition)
nmap <silent> <leader>gd <Plug>(coc-declaration)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>cf <Plug>(coc-fix-current)
nmap <silent> <leader>ce <Plug>(coc-codelens-action)
nmap <silent> <leader>ca <Plug>(coc-codeaction)
xmap <silent> <leader>ca <Plug>(coc-codeaction-selected)
nmap <silent> <leader>c= <Plug>(coc-format-selected)
xmap <silent> <leader>c= <Plug>(coc-format-selected)
nmap <silent> [w         <Plug>(coc-diagnostic-prev)
nmap <silent> ]w         <Plug>(coc-diagnostic-next)
nmap <leader>rn          <Plug>(coc-rename)
nnoremap <leader>fz :CocFzfList<cr>
nnoremap <leader>fo :CocFzfList outline<cr>

""    show doc

function! s:show_documentation() abort
  if &filetype ==# 'vim'
    try
      exe "normal \<Plug>ScripteaseHelp"
    catch /^Vim\%((\a\+)\)\=:E149:/
      echo "sorry : no help for " . expand("<cword>")
    endtry
  elseif &filetype ==# 'help'
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

""    highlight symbol under cursor
function! s:CocSymbolHLOn()
  augroup CocHighlightSymbol
    au!
    au CursorHold * silent call CocActionAsync('highlight')
  augroup end
  let s:CocHlSymbolOn = 1
endfunction

call s:CocSymbolHLOn()

function! s:CocSymbolHLOff() abort
  au! CocHighlightSymbol
  let s:CocHlSymbolOn = 0
endfunction

function! s:CocSymbolHLToggle() abort
  if s:CocHlSymbolOn
    call s:CocSymbolHLOff()
  else
    call s:CocSymbolHLOn()
  endif
endfunction

command! CocSymbolHLOn :call s:CocSymbolHLOn()
nnoremap <expr> <plug>CocSymbolHLOn <sid>CocSymbolHLOn()
if !hasmapto('<plug>CocSymbolHLOn') && maparg('[oH', 'n') ==# ''
  nmap [oH <plug>CocSymbolHLOn
endif

command! CocSymbolHLOff :call s:CocSymbolHLOff()
nnoremap <expr> <plug>CocSymbolHLOff <sid>CocSymbolHLOff()
if !hasmapto('<plug>CocSymbolHLOff') && maparg(']oH', 'n') ==# ''
  nmap ]oH <plug>CocSymbolHLOff
endif

command! CocSymbolHLToggle :call s:CocSymbolHLToggle()
nnoremap <expr> <plug>CocSymbolHLToggle <sid>CocSymbolHLToggle()
if !hasmapto('<plug>CocSymbolHLToggle') && maparg('yoH', 'n') ==# ''
  nmap yoH <plug>CocSymbolHLToggle
endif

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

