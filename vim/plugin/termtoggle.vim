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
let g:TermToggleBottom    = g:TermToggleBottom == '1' ? 'J': 'K'
let g:TermToggleRight     = g:TermToggleRight == '1' ? 'L': 'H'

nnoremap <silent> <Plug>(TermToggleV) :<c-u>call
      \ <sid>TermToggle(g:TermToggleRight, g:TermToggleWidth)<cr>
nnoremap <silent> <Plug>(TermToggle)  :<c-u>call
      \ <sid>TermToggle(g:TermToggleBottom, g:TermToggleHeight)<cr>
nnoremap <Plug>(TermPop)     :<c-u>call
      \ <sid>PopupTerminal()<cr>

" <c-z> but back with any key
function! ShowTerm() abort
  silent !read -sN 1
  redraw!
endfunction
nnoremap [= :call ShowTerm()<cr>

function! s:putTermPanel(buf, side, size) abort
  " new term if no buffer
  if a:buf == 0
    term
  else
    execute "sp" bufname(a:buf)
  endif
  " horizontal split resize
  if stridx("jkJK", a:side) >= 0
    execute "wincmd" a:side
    execute "resize" a:size
    return
  endif
  " vertical split resize
  if stridx("hlHL", a:side) >= 0
    execute "wincmd" a:side
    execute "vertical resize" a:size
  endif
endfunction

function! s:PopupTerminal() abort
  let buf = term_start("tmux_new_or_attach vim_term", #{hidden: 1, term_finish: 'close'})
  call popup_dialog(buf, #{minwidth: g:TermTogglePopWidth, minheight: g:TermTogglePopHeight, border:[]})
  return
endfunction

function! s:TermToggle(side, size) abort
  let tpbl=[]
  let closed = 0
  let tpbl = tabpagebuflist()
  " hide visible terminals
  for buf in filter(range(1, bufnr('$')), 'bufexists(bufname(v:val)) && index(tpbl, v:val)>=0')
    if getbufvar(buf, '&buftype') ==? 'terminal'
      silent execute bufwinnr(buf) . "hide"
      let closed += 1
    endif
  endfor
  if closed > 0
    return
  endif
  " open first hidden terminal
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)<0')
    if getbufvar(buf, '&buftype') ==? 'terminal'
      call s:putTermPanel(buf, a:side, a:size)
      return
    endif
  endfor
  " open new terminal
  call s:putTermPanel(0, a:side, a:size)
endfunction
