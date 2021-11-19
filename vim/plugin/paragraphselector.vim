if exists('g:plugin_paragraphselector')
  finish
endif
let g:plugin_qf = 1

function! s:visualParagraphUp() range abort
  if mode() != 'v'
    normal! gv
  endif
  let curline = getcurpos()[1]
  let wantcol = getcurpos()[4]
  let wantline = search('^$\n\zs.*[^\n]', 'nWbe')
  if wantline == 0
    if &virtualedit ==# 'block'
      exe "normal gg"
    endif
    return
  endif
  if wantline == curline
    normal k
    let wantline = search('^$\n\zs.*[^\n]', 'nWbe')
  endif
  exe "normal" wantline . "gg"
  if getcurpos()[1] == 1
    exe "normal ^" . expand(wantcol-1) . "\<right>"
  endif
endfunction

function! s:visualParagraphDown() range abort
  if mode() != 'v'
    normal! gv
  endif
  let curline = getcurpos()[1]
  let wantcol = getcurpos()[4]
  let wantline = search('[^\n].*\n^$', 'nW')
  if wantline == 0
    if &virtualedit ==# 'block'
      normal G
    endif
    return
  endif
  exe "normal" wantline . "gg"
endfunction

command! -range ParaSelUp :call <sid>visualParagraphUp()
command! -range ParaSelDown :call <sid>visualParagraphDown()

vnoremap <silent> <c-j> :call <sid>visualParagraphDown()<cr>
vnoremap <silent> <c-k> :call <sid>visualParagraphUp()<cr>

" " Note: error: not allowed there
" xnoremap <expr> <Plug>ParaSelUp   <sid>visualParagraphUp()
" xnoremap <expr> <Plug>ParaSelDown <sid>visualParagraphDown()

" if !hasmapto('<Plug>ParaSelUp') && maparg('<c-k>','x') ==# ''
"   xmap <c-k> <Plug>ParaSelUp()
" endif
" if !hasmapto('<Plug>ParaSelDown') && maparg('<c-j>','x') ==# ''
"   xmap <c-j> <Plug>ParaSelDown()
" endif
