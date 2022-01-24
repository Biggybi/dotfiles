if exists('g:plugin_termtoggle')
  finish
endif
let g:plugin_termtoggle = 1

let g:TermToggleHeight    = get(g:, 'TermToggleHeight', '6')
let g:TermToggleWidth     = get(g:, 'TermToggleWidth', '50')
let g:TermTogglePopHeight = get(g:, 'TermTogglePopHeight', '25')
let g:TermTogglePopWidth  = get(g:, 'TermTogglePopWidth', '80')
let g:TermToggleBottom    = get(g:, 'TermToggleBottom', '1')
let g:TermToggleRight     = get(g:, 'TermToggleRight', '1')
let g:TermToggleBottom    = g:TermToggleBottom !~ '{J,K}' || g:TermToggleBottom == '1' ? 'J': 'K'
let g:TermToggleRight     = g:TermToggleBottom !~ '{L,H}' || g:TermToggleRight == '1' ? 'L': 'H'

command! TermToggleV :call <sid>TermToggle(g:TermToggleRight, g:TermToggleWidth)
command! TermToggle  :call <sid>TermToggle(g:TermToggleBottom, g:TermToggleHeight)
command! TermPop     :call <sid>PopupTerminal()

nnoremap yot :TermToggle<cr>
nnoremap yo<c-t> :TermToggleV<cr>
nnoremap yoT :TermPop<cr>

" " Note: does not work but whyyyyyyyyyyyyyyy?
" nnoremap <expr> <Plug>TermToggleV <sid>TermToggle(g:TermToggleRight, g:TermToggleWidth)
" nnoremap <expr> <Plug>TermToggle  <sid>TermToggle(g:TermToggleBottom, g:TermToggleHeight)
" nnoremap <expr> <Plug>TermPop     <sid>PopupTerminal()
" if !hasmapto('<Plug>TermToggle') && maparg('yot','n') ==# ''
"   nmap yot <Plug>TermToggle
" endif
" if !hasmapto('<Plug>TermToggleV') && maparg('yo<c-t>','n') ==# ''
"   nmap yo<c-t> <Plug>TermToggleV
" endif
" if !hasmapto('<Plug>TermPop') && maparg('yoT','n') ==# ''
"   nmap yoT <Plug>TermPop
" endif

" <c-z> but back with any key
function! ShowTerm() abort
  silent !read -sN 1
  redraw!
endfunction
nnoremap [= :call ShowTerm()<cr>

function! s:putTermPanel(buf, side, size) abort
  " new term if no buffer
  if a:buf == 0
    " clear screen (workaround for bashrc base16 trash)
    call feedkeys("\<c-l>")
    term
  else
    execute "sp" bufname(a:buf)
  endif
  " horizontal split resize
  if stridx("jkJK", a:side) >= 0
    execute "wincmd" a:side
    execute "resize" a:size
    setlocal winfixheight
    setlocal nowinfixwidth
    " vertical split resize
  endif
  if stridx("hlHL", a:side) >= 0
    execute "wincmd" a:side
    execute "vertical resize" a:size
    setlocal winfixwidth
    setlocal nowinfixheight
  endif
endfunction

function! s:PopupTerminal() abort
  let buf = term_start("tmux_new_or_attach vim_term", #{hidden: 1, term_finish: 'close'})
  call popup_dialog(buf, #{minwidth: g:TermTogglePopWidth, minheight: g:TermTogglePopHeight, border:[]})
  return
endfunction

function! s:HideVisibleTerm(tpbl) abort
  let closed = 0
  for buf in filter(range(1, bufnr('$')), 'bufexists(bufname(v:val)) && index(a:tpbl, v:val)>=0')
    if getbufvar(buf, '&buftype') ==? 'terminal'
      silent execute bufwinnr(buf) . "hide"
      let closed += 1
    endif
  endfor
  return closed
endfunction

function! s:OpenFirstTerm(tpbl, side, size) abort
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(a:tpbl, v:val)<0')
    if getbufvar(buf, '&buftype') ==? 'terminal'
      call s:putTermPanel(buf, a:side, a:size)
      return
    endif
  endfor
endfunction

function! s:TermToggle(side, size) abort
  let tpbl = tabpagebuflist()
  if s:HideVisibleTerm(tpbl) > 0
    return
  endif
  call s:OpenFirstTerm(tpbl, a:side, a:size)
  call s:putTermPanel(0, a:side, a:size)
endfunction
