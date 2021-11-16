if exists('g:plugin_modecolor')
  finish
endif
let g:plugin_modecolor = 1

function! s:getHLString(group) abort
  if empty(a:group)
    return ''
  endif
  let fg = synIDattr(hlID(a:group), "fg#")
  let bg = synIDattr(hlID(a:group), "bg#")
  if empty(bg) || empty(bg)
    return ''
  endif
  let env = &termguicolors == 1 ? 'gui' : 'cterm'
  return printf("%sfg=%s %sbg=%s", env, fg, env, bg)
endfunction

" TODO: optional hl groups (link to existing groups by default)
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
  let g:modecolor_main  = get(g:, 'modecolor_hl_group_normal', 'SuliNormal')
  let g:modecolor_extra = get(g:, 'modecolor_hl_group_extra', 'CursorLineNr')
  let s:HLGroupMain     = s:getHLString(g:modecolor_main)
  let s:HLGroupExtra    = s:getHLString(g:modecolor_extra)
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

function! s:modeColorExtraHL(color) abort
  let colorstring = s:HLStrings[a:color]
  if empty(a:color) || empty(colorstring)
    return ''
  endif
  if a:color ==? 'Normal'
    exe "silent hi" g:modecolor_extra s:HLGroupExtra
    return
  endif
  exe "silent hi" g:modecolor_extra colorstring
endfunction

function! s:modeColorMainHL(color) abort
  " exe "silent hi" g:modecolor_main a:color
  let colorstring = s:HLStrings[a:color]
  exe "silent hi User1" colorstring
endfunction

function! s:modeColorAllHL(color = '') abort
  if empty(a:color)
    call s:modeColorExtraHL(g:modecolor_main)
    call s:modeColorMainHL(g:modecolor_extra)
  endif
  call s:modeColorExtraHL(a:color)
  call s:modeColorMainHL(a:color)
endfunction

function! s:modeColorSwitch(_) abort
  if g:modecolor_timer_switch == 0
    call timer_pause(s:modecolor_timer, 1)
    return s:modeColorAllHL('Normal')
  endif
  let curr_mode = mode()
  if curr_mode =~? '[s]'
    return s:modeColorAllHL('Replace')
  elseif curr_mode =~# '[Ri]'
    return s:modeColorAllHL('Insert')
  elseif curr_mode =~? '[v]'
    return s:modeColorAllHL('Visual')
  elseif curr_mode ==? 'c'
    return s:modeColorAllHL('Cmd')
  elseif ! exists('*state')
    return s:modeColorAllHL('Normal')
  elseif state() =~# '[mo]'
    return s:modeColorAllHL('Pending')
  elseif state() =~# '[S]'
    return s:modeColorAllHL('FTSearch')
  else
    return s:modeColorAllHL('Normal')
  endif
  return s:modeColorAllHL('Normal')
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
    call s:modeColorAllHL('Normal')
    echo 'color mode change off'
  endif
endfunction

let g:modecolor_timer_switch = get(g:, 'modecolor_timer_switch', 1)
let g:modecolor_refresh_time = get(g:, 'modecolor_refresh_time', 50)

function! s:startModeColor() abort
  if g:modecolor_timer_switch == 0
    call s:modeColorAllHL('Normal')
  elseif exists('timer_info(s:modecolor_timer)') <= 0
    let Switcher = function('s:modeColorSwitch')
    let s:modecolor_timer = timer_start(g:modecolor_refresh_time, Switcher, {'repeat': -1})
  endif
endfunction

if exists('s:modecolor_timer')
  call timer_stop(s:modecolor_timer)
  if s:HLGroupMain != ''
    silent exe "hi" g:modecolor_extra s:HLGroupExtra
  endif
  call s:startModeColor()
endif

call s:modeColorInit()

if has("nvim")
  augroup NvimColorAu
    au!
    au ColorScheme *
          \ call s:modeColorInit()
    au InsertEnter *
          \ call s:modeColorAllHL('Insert')
    au CmdlineEnter *
          \ call s:modeColorAllHL('Cmd')
  augroup END
endif

augroup StartModeColor
  au!
  au ColorScheme *
        \ call s:modeColorInit()
  au BufWinEnter ?\+ ++once
        \ call s:startModeColor()
  au WinEnter *
        \ call s:modeColorAllHL('Normal')
augroup end

" ModeColorExtra[!] [Group]
" force a color, and deactivate auto switch
" highlight `statusline` and `extra` with the given Group
" if `!` is given, `extra` takes the `normal` value

command! -bang -nargs=? -complete=highlight ModeColorExtra
      \ if exists('s:modecolor_timer') && ! timer_info(s:modecolor_timer)[0]['paused']
      \ |  call timer_pause(s:modecolor_timer, 1)
      \ |  call s:modeColorMainHL()
      \ |endif
      \ |call s:modeColorExtraHL(s:getHLString(<q-args>))

command! -bang -nargs=? -complete=highlight ModeColorMain
      \ if exists('s:modecolor_timer') && ! timer_info(s:modecolor_timer)[0]['paused']
      \ |  call timer_pause(s:modecolor_timer, 1)
      \ |  call s:modeColorExtraHL()
      \ |endif
      \ |call s:modeColorMainHL(s:getHLString(<q-args>))

command! -bang -nargs=? -complete=highlight ModeColorAll
      \ if exists('s:modecolor_timer') && ! timer_info(s:modecolor_timer)[0]['paused']
      \ |  call timer_pause(s:modecolor_timer, 1)
      \ |endif
      \ |call s:modeColorAllHL(s:HLString(<q-args>))

" toggle color switch
command! -nargs=0 ModeColorToggle call s:modeColorToggle()
silent! noremap <silent> <unique> <script> <plug>(modeColorToggle)
      \ :set lz<cr>:call <sid>modeColorToggle()<cr>:set nolz<cr>
