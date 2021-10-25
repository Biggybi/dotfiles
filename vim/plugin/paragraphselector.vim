if exists('g:plugin_paragraphselector')
  finish
endif
let g:plugin_qf = 1

function! s:visualParagraphUp() range abort
  if mode() != 'v'
    normal! gv
  endif
  let curline = getcurpos('.')[1]
  let wantcol = getcurpos('.')[4]
  let wantline = search('^$\n\zs.*[^\n]', 'nWbe')
  if wantline == 0
    echo wantline
    if &virtualedit ==# 'block'
      normal gg
    endif
    return
  endif
  exe "normal" wantline . "gg"
endfunction

function! s:visualParagraphDown() range abort
  if mode() != 'v'
    normal! gv
  endif
  let curline = getcurpos('.')[1]
  let wantcol = getcurpos('.')[4]
  let wantline = search('[^\n].*\n^$', 'nW')
  if wantline == 0
    if &virtualedit ==# 'block'
      normal G
    endif
    return
  endif
  echo wantline
  exe "normal" wantline . "gg"
endfunction

vnoremap <silent> <c-j> :call <sid>visualParagraphDown()<cr>
vnoremap <silent> <c-k> :call <sid>visualParagraphUp()<cr>

xnoremap <expr> <Plug>ParaSelUp   <sid>visualParagraphUp()
xnoremap <expr> <Plug>ParaSelDown <sid>visualParagraphDown()

command! -range ParaSelUp :call <sid>visualParagraphUp()
command! -range ParaSelDown :call <sid>visualParagraphDown()
