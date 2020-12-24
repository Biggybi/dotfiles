if exists('g:plugin_modecolor')
  finish
endif
let g:plugin_modecolor = 1

let g:sl_color_group = get(g:, 'sl_color_group', 'CursorLineNr')

let g:modecolor_timer = timer_start(100, 'ModeGetter', {'repeat': -1})
function! ModeGetter(_) abort
  if mode() =~? 'i' "insert mode
    return
  endif
  if mode() =~? '[s]'
    return ModeColor('StatusLineReplace')
  endif
  if mode() =~# 'R'
    return ModeColor('StatusLineInsert')
  endif
  if mode() =~? '[v]'
    return ModeColor('StatusLineVisual')
  endif
  if mode() ==? 'c'
    return ModeColor('StatusLineCmd')
  endif
  if has("nvim")
    return ModeColorNormal('StatusLineNormal')
  endif
  if state() =~# '[mo]'
    return ModeColor('StatusLinePending')
  elseif state() =~# '[S]'
    return ModeColor('StatusLineFTSearch')
  else
    return ModeColorNormal('StatusLineNormal')
  endif
endfunction

function! ModeColor(color) abort
  exe "hi User1" GetColor(a:color, a:color)
  exe "hi" g:sl_color_group GetColor(a:color, a:color)
  return
endfunction

function! ModeColorNormal(color) abort
  exe "hi User1" GetColor(a:color, a:color)
  exe "hi" g:sl_color_group . " guifg=" . s:save_color_group_fg . " guibg=" . s:save_color_group_bg
  return
endfunction

let s:save_color_group_fg = synIDattr(hlID(g:sl_color_group), "fg#")
let s:save_color_group_bg = synIDattr(hlID(g:sl_color_group), "bg#")
function SaveColorGroup()
  let s:save_color_group_fg = synIDattr(hlID(g:sl_color_group), "fg#")
  let s:save_color_group_bg = synIDattr(hlID(g:sl_color_group), "bg#")
endfunction

augroup SaveColorGroup
  au!
  au ColorScheme * call SaveColorGroup()
augroup end

function! SetStatusLineColorsAll() abort
  call ModeColorNormal('StatusLineNormal')
  exe "hi User1" GetColor('StatusLineNormal', 'StatusLineNormal')
  exe "hi User2" GetColor('StatusLineActiveLeft', 'StatusLineActiveLeft')
  exe "hi User3" GetColor('StatusLineVisual', 'StatusLineVisual')
  exe "hi User4" GetColor('StatusLineInsert', 'normal')
  exe "hi User5" GetColor('StatusLineImportant', 'StatusLineActiveLeft')
  exe "hi User6" GetColor('StatusLineImportant', 'StatusLineActiveMid')
endfunction

function! GetColor(group_fg, group_bg) abort
  let group_fg = synIDattr(hlID(a:group_fg), "fg#")
  let group_bg = synIDattr(hlID(a:group_bg), "bg#")
  return "guifg=".group_fg . " guibg=".group_bg
endfunction

nnoremap <expr> yov timer_info(g:modecolor_timer)[0]['paused'] == 0 ?
      \ ":call timer_pause(g:modecolor_timer, '1')<cr>:silent! call SetStatusLineColorsAll()<cr>:echo 'color mode change off'<cr>" :
      \ ":call timer_pause(g:modecolor_timer, '0')<cr>:echo 'color mode change on'<cr>"
