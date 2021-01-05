if exists('g:plugin_modecolor')
  finish
endif
let g:plugin_modecolor = 1

let g:mode_color_hl_group = get(g:, 'mode_color_hl_group', 'CursorLineNr')

let s:save_color_group_fg = synIDattr(hlID(g:mode_color_hl_group), "fg#")
let s:save_color_group_bg = synIDattr(hlID(g:mode_color_hl_group), "bg#")
function SaveColorGroup()
  let s:save_color_group_fg = synIDattr(hlID(g:mode_color_hl_group), "fg#")
  let s:save_color_group_bg = synIDattr(hlID(g:mode_color_hl_group), "bg#")
endfunction

function! GetColor(group_fg, group_bg) abort
  let group_fg = synIDattr(hlID(a:group_fg), "fg#")
  let group_bg = synIDattr(hlID(a:group_bg), "bg#")
  return "guifg=".group_fg . " guibg=".group_bg
endfunction

function! SetColor(color) abort
  exe "hi User1" GetColor(a:color, a:color)
  exe "hi" g:mode_color_hl_group GetColor(a:color, a:color)
  return
endfunction

function! SetStatusLineHilights() abort
  exe "silent! hi User1" GetColor('StatusLineNormal', 'StatusLineNormal')
  exe "silent! hi User2" GetColor('StatusLineActiveLeft', 'StatusLineActiveLeft')
  exe "silent! hi User3" GetColor('StatusLineVisual', 'StatusLineVisual')
  exe "silent! hi User4" GetColor('StatusLineInsert', 'normal')
  exe "silent! hi User5" GetColor('StatusLineImportant', 'StatusLineActiveLeft')
  exe "silent! hi User6" GetColor('StatusLineImportant', 'StatusLineActiveMid')
endfunction

let g:modecolor_timer = timer_start(100, 'ModeColorSwitch', {'repeat': -1})
function! ModeColorSwitch(_) abort
  if mode() =~? '[s]'
    return SetColor('StatusLineReplace')
  elseif mode() =~# '[Ri]'
    return SetColor('StatusLineInsert')
  elseif mode() =~? '[v]'
    return SetColor('StatusLineVisual')
  elseif mode() ==? 'c'
    return SetColor('StatusLineCmd')
  elseif has("nvim")
    return SetColor('StatusLineNormal')
  elseif state() =~# '[mo]'
    return SetColor('StatusLinePending')
  elseif state() =~# '[S]'
    return SetColor('StatusLineFTSearch')
  else
    return SetColor('StatusLineNormal')
  endif
  return SetColor('StatusLineNormal')
endfunction

function! ModeColorToggle(on)
  if a:on == 1
    call timer_pause(g:modecolor_timer, '0')
    echo 'color mode change on'
  else
    call timer_pause(g:modecolor_timer, '1')
    silent! SetStatusLineHilights()
    call SetColor('StatusLineNormal')
    echo 'color mode change off'
  endif
endfunction

augroup StartModeColor
  au!
  au ColorScheme *
        \ call SaveColorGroup()
  au VimEnter,ColorScheme,SourcePost *
        \ call SetStatusLineHilights()
augroup end

nnoremap <expr> yov timer_info(g:modecolor_timer)[0]['paused'] == 0 ?
      \ ":call ModeColorToggle(0)<cr>" :
      \ ":call ModeColorToggle(1)<cr>"
