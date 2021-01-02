if exists('g:plugin_modecolor')
  finish
endif
let g:plugin_modecolor = 1

let g:sl_hilight_group = get(g:, 'sl_hilight_group', 'CursorLineNr')

let g:modecolor_timer = timer_start(100, 'ModeHilight', {'repeat': -1})
function! ModeHilight(_) abort
  if mode() =~? 'i' "insert mode
    return
  elseif mode() =~? '[s]'
    return SetHilight('StatusLineReplace')
  elseif mode() =~# 'R'
    return SetHilight('StatusLineInsert')
  elseif mode() =~? '[v]'
    return SetHilight('StatusLineVisual')
  elseif mode() ==? 'c'
    return SetHilight('StatusLineCmd')
  elseif has("nvim")
    return SetHilightNormal('StatusLineNormal')
  elseif state() =~# '[mo]'
    return SetHilight('StatusLinePending')
  elseif state() =~# '[S]'
    return SetHilight('StatusLineFTSearch')
  else
    return SetHilightNormal('StatusLineNormal')
  endif
endfunction

function! SetHilight(color) abort
  exe "hi User1" GetColor(a:color, a:color)
  exe "hi" g:sl_hilight_group GetColor(a:color, a:color)
  return
endfunction

function! SetHilightNormal(color) abort
  exe "hi User1" GetColor(a:color, a:color)
  exe "hi" g:sl_hilight_group . " guifg=" . s:save_color_group_fg . " guibg=" . s:save_color_group_bg
  return
endfunction

let s:save_color_group_fg = synIDattr(hlID(g:sl_hilight_group), "fg#")
let s:save_color_group_bg = synIDattr(hlID(g:sl_hilight_group), "bg#")
function SaveColorGroup()
  let s:save_color_group_fg = synIDattr(hlID(g:sl_hilight_group), "fg#")
  let s:save_color_group_bg = synIDattr(hlID(g:sl_hilight_group), "bg#")
endfunction

augroup SaveColorGroup
  au!
  au ColorScheme * call SaveColorGroup()
augroup end

function! SetStatusLineHilights() abort
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
      \ ":call timer_pause(g:modecolor_timer, '1')<cr>:silent! call SetStatusLineHilights()<cr>:echo 'color mode change off'<cr>" :
      \ ":call timer_pause(g:modecolor_timer, '0')<cr>:echo 'color mode change on'<cr>"
