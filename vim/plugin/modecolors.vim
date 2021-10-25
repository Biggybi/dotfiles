if exists('g:plugin_modecolor')
  finish
endif
let g:plugin_modecolor = 1

function! s:getHLString(group) abort
  if a:group == ''
    return ''
  endif
  let group_fg = synIDattr(hlID(a:group), "fg#")
  let group_bg = synIDattr(hlID(a:group), "bg#")
  if group_fg == ''
    return ''
  endif
  if group_bg == ''
    return ''
  endif
  if &termguicolors == 1
    return "guifg=".group_fg . " guibg=".group_bg
  else
    return "ctermfg=".group_fg . " ctermbg=".group_bg
  endif
endfunction

function! s:setHLDic() abort
  let s:HLStrings = {
        \ 'Mid'      : s:getHLString('SuliMid'),
        \ 'Outer'    : s:getHLString('SuliOuter'),
        \ 'Normal'   : s:getHLString('SuliNormal'),
        \ 'Insert'   : s:getHLString('SuliInsert'),
        \ 'Visual'   : s:getHLString('SuliVisual'),
        \ 'Replace'  : s:getHLString('SuliReplace'),
        \ 'Pending'  : s:getHLString('SuliPending'),
        \ 'FTSearch' : s:getHLString('SuliFTSearch'),
        \ 'Cmd'      : s:getHLString('SuliCmd'),
        \ 'FileMod'  : s:getHLString('SuliFileMod'),
        \ 'GitMod'   : s:getHLString('SuliGitMod'),
        \ 'CurDir'   : s:getHLString('SuliCurDir'),
        \ 'Git'      : s:getHLString('SuliGit'),
        \ 'GitSub'   : s:getHLString('SuliGitSub'),
        \ 'Sep'      : s:getHLString('SuliSep')}
endfunction

function! s:setExtraStrings() abort
  let g:modecolor_extra = get(g:, 'modecolor_hl_group', 'CursorLineNr')
  let g:modecolor_extra_normal = get(g:, 'modecolor_hl_group_normal', 'CursorLineNr')
  let s:HLGroupNormal = s:getHLString(g:modecolor_extra_normal)
endfunction

function! s:modeColorHL(color) abort
  if a:color == '!'
    if g:modecolor_extra != ''
      exe "silent hi" g:modecolor_extra s:HLGroupNormal
    endif
    return
  endif
  if a:color != ''
    exe "silent hi User1" a:color
  else
  endif
  if g:modecolor_extra ==# ''
    return
  endif
  if a:color is s:HLStrings['Normal']
    exe "silent hi" g:modecolor_extra s:HLGroupNormal
  else
    exe "silent hi" g:modecolor_extra a:color
  endif
endfunction

function! s:highlightUserGroups() abort
  exe 'silent! hi User1' s:HLStrings['Normal']
  exe 'silent! hi User2' s:HLStrings['Outer']
  exe 'silent! hi User3' s:HLStrings['Mid']
  exe 'silent! hi User4' s:HLStrings['GitMod']
  exe 'silent! hi User5' s:HLStrings['FileMod']
  exe 'silent! hi User6' s:HLStrings['CurDir']
  exe 'silent! hi User7' s:HLStrings['Git']
  exe 'silent! hi User8' s:HLStrings['GitSub']
  exe 'silent! hi User9' s:HLStrings['Sep']
endfunction

function! s:modeColorInit() abort
  call s:setHLDic()
  call s:setExtraStrings()
  call s:highlightUserGroups()
endfunction

function! s:modeColorSwitch(_) abort
  if g:modecolor_timer_switch == 0
    call timer_pause(s:modecolor_timer, 1)
    return s:modeColorHL(s:HLStrings['Normal'])
  endif
  let curr_mode = mode()
  if curr_mode =~? '[s]'
    return s:modeColorHL(s:HLStrings['Replace'])
  elseif curr_mode =~# '[Ri]'
    return s:modeColorHL(s:HLStrings['Insert'])
  elseif curr_mode =~? '[v]'
    return s:modeColorHL(s:HLStrings['Visual'])
  elseif curr_mode ==? 'c'
    return s:modeColorHL(s:HLStrings['Cmd'])
  elseif ! exists('*state')
    return s:modeColorHL(s:HLStrings['Normal'])
  elseif state() =~# '[mo]'
    return s:modeColorHL(s:HLStrings['Pending'])
  elseif state() =~# '[S]'
    return s:modeColorHL(s:HLStrings['FTSearch'])
  else
    return s:modeColorHL(s:HLStrings['Normal'])
  endif
  return s:modeColorHL(s:HLStrings['Normal'])
endfunction

function! s:modeColorToggle()
  if ! exists('s:modecolor_timer')
    if g:modecolor_timer_switch == 0
      let g:modecolor_timer_switch = 1
      echo 'color mode change on'
      call s:startModeColor()
    endif
    return
  endif
  if timer_info(s:modecolor_timer)[0]['paused']
    call timer_pause(s:modecolor_timer, '0')
    echo 'color mode change on'
  elseif s:modecolor_timer
    call timer_pause(s:modecolor_timer, '1')
    silent! s:modeColorInit()
    call s:modeColorHL(s:HLStrings['Normal'])
    echo 'color mode change off'
  endif
endfunction

let g:modecolor_timer_switch = get(g:, 'modecolor_timer_switch', 1)
let g:modecolor_refresh_time = get(g:, 'modecolor_refresh_time', 50)

function! s:startModeColor() abort
  if g:modecolor_timer_switch == 0
    call s:modeColorHL(s:HLStrings['Normal'])
  elseif exists('timer_info(s:modecolor_timer)') <= 0
    let Switcher = function('s:modeColorSwitch')
    let s:modecolor_timer = timer_start(g:modecolor_refresh_time, Switcher, {'repeat': -1})
  endif
endfunction

if exists('s:modecolor_timer')
  call timer_stop(s:modecolor_timer)
  if s:HLGroupNormal != ''
    silent exe "hi" g:modecolor_extra s:HLGroupNormal
  endif
  call s:startModeColor()
endif

call s:modeColorInit()

augroup StartModeColor
  au!
  au ColorScheme *
        \ call s:modeColorInit()
  au BufWinEnter ?\+ ++once
        \ call s:startModeColor()
  au WinEnter *
        \ call s:modeColorHL(s:HLStrings['Normal'])
augroup end

" ModeColorExtra[!] [Group]
" force a color, and deactivate auto switch
" highlight `statusline` and `extra` with the given Group
" if `!` is given, `extra` takes the `normal` value
command! -bang -nargs=? -complete=highlight ModeColorExtra
      \ if exists('s:modecolor_timer') && ! timer_info(s:modecolor_timer)[0]['paused']
      \ |  call timer_pause(s:modecolor_timer, 1)
      \ |endif
      \ |call s:modeColorHL(s:getHLString(<f-args>))
      \ |if expand('<bang>') == '!'
      \ |  call s:modeColorHL('!')
      \ |endif

" toggle color switch
command! -nargs=0 ModeColorToggle call s:modeColorToggle()
silent! noremap <silent> <unique> <script> <plug>(modeColorToggle)
      \ :set lz<cr>:call <sid>modeColorToggle()<cr>:set nolz<cr>
