if exists('g:plugin_modecolor')
  finish
endif
let g:plugin_modecolor = 1

let g:mode_color_hl_group = get(g:, 'mode_color_hl_group', 'CursorLineNr')

let s:save_color_group_fg = synIDattr(hlID(g:mode_color_hl_group), "fg#")
let s:save_color_group_bg = synIDattr(hlID(g:mode_color_hl_group), "bg#")

function s:saveColorGroup()
  let s:save_color_group_fg = synIDattr(hlID(g:mode_color_hl_group), "fg#")
  let s:save_color_group_bg = synIDattr(hlID(g:mode_color_hl_group), "bg#")
endfunction

function! s:getColor(group_fg, group_bg) abort
  let group_fg = synIDattr(hlID(a:group_fg), "fg#")
  let group_bg = synIDattr(hlID(a:group_bg), "bg#")
  return "guifg=".group_fg . " guibg=".group_bg
endfunction

function! s:setColor(color) abort
  exe "hi User1" s:getColor(a:color, a:color)
  exe "hi" g:mode_color_hl_group s:getColor(a:color, a:color)
  return
endfunction

function! s:setStatusLineHighlights() abort
  exe "silent! hi User1" s:getColor('StatusLineNormal', 'StatusLineNormal')
  exe "silent! hi User2" s:getColor('StatusLineActiveLeft', 'StatusLineActiveLeft')
  exe "silent! hi User3" s:getColor('StatusLineVisual', 'StatusLineVisual')
  exe "silent! hi User4" s:getColor('StatusLineInsert', 'normal')
  exe "silent! hi User5" s:getColor('StatusLineImportant', 'StatusLineActiveLeft')
  exe "silent! hi User6" s:getColor('StatusLineImportant', 'StatusLineActiveMid')
endfunction

function! ModeColorSwitch(_) abort
  let curr_mode = mode()
  if curr_mode =~? '[s]'
    return s:setColor('StatusLineReplace')
  elseif curr_mode =~# '[Ri]'
    return s:setColor('StatusLineInsert')
  elseif curr_mode =~? '[v]'
    return s:setColor('StatusLineVisual')
  elseif curr_mode ==? 'c'
    return s:setColor('StatusLineCmd')
  elseif has("nvim")
    return s:setColor('StatusLineNormal')
  elseif state() =~# '[mo]'
    return s:setColor('StatusLinePending')
  elseif state() =~# '[S]'
    return s:setColor('StatusLineFTSearch')
  else
    return s:setColor('StatusLineNormal')
  endif
  return s:setColor('StatusLineNormal')
endfunction

function! s:modeColorToggle()
  if timer_info(g:modecolor_timer)[0]['paused']
    call timer_pause(g:modecolor_timer, '0')
    echo 'color mode change on'
  elseif g:modecolor_timer
    call timer_pause(g:modecolor_timer, '1')
    silent! s:setStatusLineHighlights()
    call s:setColor('StatusLineNormal')
    echo 'color mode change off'
  endif
endfunction

augroup StartModeColor
  au!
  au ColorScheme *
        \ call s:saveColorGroup()
  au ColorScheme,SourcePost *
        \ call s:setStatusLineHighlights()
augroup end
let g:modecolor_timer = timer_start(100, 'ModeColorSwitch', {'repeat': -1})

noremap <silent> <unique> <script> <plug>(modeColorToggle)
\ :set lz<cr>:call <sid>modeColorToggle()<cr>:set nolz<cr>
