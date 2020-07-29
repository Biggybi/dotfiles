if exists('g:modecolor')
  finish
endif
let g:modecolor = 1

let g:sl_color_group = get(g:, 'sl_color_group', 'CursorLineNr')
" let g:sl_color_group = "CursorLineNr"

call timer_start(30, 'ModeGetter', {'repeat': -1})
function! ModeGetter(_) abort
  if mode() =~? 'i' "insert mode
    return
  endif
  if mode() =~? '[s]'
    call ModeColor('StatusLineReplace')
    return
  endif
  if mode() =~# 'R'
    call ModeColor('StatusLineReplace')
    return
  endif
  if mode() =~? '[v]'
    call ModeColor('StatusLineVisual')
    return
  endif
  if mode() ==? 'c'
    call ModeColor('StatusLineCmd')
    return
  endif
  if has("nvim")
    call ModeColor('StatusLineNormal')
    return
  endif
  if state() =~# '[mo]'
    call ModeColor('StatusLinePending')
    return
  elseif state() =~# '[S]'
    call ModeColor('StatusLineFTSearch')
    return
  else
    call ModeColor('StatusLineNormal')
    return
  endif
endfunction

function! ModeColor(color) abort
  exe "hi" g:sl_color_group GetColor(a:color, a:color)
  exe "hi User1" GetColor(a:color, a:color)
endfunction

function! SetStatusLineColorsAll() abort
  exe "hi User1" GetColor('StatusLineNormal', 'StatusLineNormal')
  exe "hi User2" GetColor('StatusLineActiveLeft', 'StatusLineActiveLeft')
  exe "hi User3" GetColor('StatusLineVisual', 'StatusLineVisual')
  exe "hi User4" GetColor('StatusLineInsert', 'normal')
  exe "hi User5" GetColor('normal', 'normal')
  exe "hi" g:sl_color_group GetColor('StatusLineNormal', 'StatusLineNormal')
endfunction

function! GetColor(group_fg, group_bg) abort
  let group_fg = synIDattr(hlID(a:group_fg), "fg#")
  let group_bg = synIDattr(hlID(a:group_bg), "bg#")
  return "guifg=".group_fg . " guibg=".group_bg
endfunction
function! LongestLineLen() abort
  let len = max(map(range(1, line('$')), "virtcol([v:val, '$'])-1"))
  return len
endfunction
