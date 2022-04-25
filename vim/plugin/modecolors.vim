if exists('g:plugin_modecolor')
  finish
endif
let g:plugin_modecolor = 1

"" Get options
let g:modecolor_prefix =       get(g:, 'modecolor_prefix', 'Suli')
let g:modecolor_timer_switch = get(g:, 'modecolor_timer_switch', 1)
let g:modecolor_refresh_time = get(g:, 'modecolor_refresh_time', 50)

"" Autocommand functions
function! s:getHLString(group) abort
  if empty(a:group)
    return ''
  endif
  let fg = synIDattr(hlID(a:group), "fg#")
  let bg = synIDattr(hlID(a:group), "bg#")
  if empty(fg)
    let fg = synIDattr(hlID(s:modecolor_base), "fg#")
  endif
  if empty(bg)
    let bg = synIDattr(hlID(s:modecolor_base), "bg#")
  endif
  let env = &termguicolors == 1 ? 'gui' : 'cterm'
  return printf("%sfg=%s %sbg=%s", env, fg, env, bg)
endfunction

" TODO: optional hl groups (link to existing groups by default)
function! s:setHLDic() abort
  let s:HLStrings = {
        \ 'Mid'      : s:getHLString(g:modecolor_prefix.'Mid'),
        \ 'Outer'    : s:getHLString(g:modecolor_prefix.'Outer'),
        \ 'Normal'   : s:getHLString(g:modecolor_prefix.'Normal'),
        \ 'Insert'   : s:getHLString(g:modecolor_prefix.'Insert'),
        \ 'Visual'   : s:getHLString(g:modecolor_prefix.'Visual'),
        \ 'Replace'  : s:getHLString(g:modecolor_prefix.'Replace'),
        \ 'Pending'  : s:getHLString(g:modecolor_prefix.'Pending'),
        \ 'FTSearch' : s:getHLString(g:modecolor_prefix.'FTSearch'),
        \ 'Cmd'      : s:getHLString(g:modecolor_prefix.'Cmd'),
        \ 'FileMod'  : s:getHLString(g:modecolor_prefix.'FileMod'),
        \ 'GitMod'   : s:getHLString(g:modecolor_prefix.'GitMod'),
        \ 'CurDir'   : s:getHLString(g:modecolor_prefix.'CurDir'),
        \ 'Git'      : s:getHLString(g:modecolor_prefix.'Git'),
        \ 'GitSub'   : s:getHLString(g:modecolor_prefix.'GitSub'),
        \ 'Sep'      : s:getHLString(g:modecolor_prefix.'Sep')}
endfunction

function! s:setExtraStrings() abort
  let s:modecolor_base  = get(g:, 'modecolor_hl_group_normal', 'SuliNormal')
  let s:modecolor_main  = get(g:, 'modecolor_hl_group_normal', 'User1')
  let s:modecolor_extra = get(g:, 'modecolor_hl_group_extra', 'CursorLineNr')
  let s:HLGroupMain     = s:getHLString(s:modecolor_base)
  let s:HLGroupExtra    = s:getHLString(s:modecolor_extra)
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

function! s:modeColorHL(group) abort
  exe "silent hi" s:modecolor_main s:HLStrings[a:group]
  let colorstring = s:HLStrings[a:group]
  if a:group ==? 'Normal'
    exe "silent hi" s:modecolor_extra s:HLGroupExtra
    return
  endif
  exe "silent hi" s:modecolor_extra colorstring
endfunction

function! s:mcSwitch(_) abort
  if g:modecolor_timer_switch == 0
    call timer_pause(s:mc_timer, 1)
    return s:modeColorHL('Normal')
  endif
  let curr_mode = mode()
  if curr_mode =~? '[s]'     | return s:modeColorHL('Replace')  |
  elseif curr_mode =~# '[Ri]'  | return s:modeColorHL('Insert')   |
  elseif curr_mode =~? '[v]' | return s:modeColorHL('Visual')   |
  elseif curr_mode ==? 'c'     | return s:modeColorHL('Cmd')      |
  elseif !exists('*state')     | return s:modeColorHL('Normal')   |
  elseif state() =~# '[mo]'    | return s:modeColorHL('Pending')  |
  elseif state() =~# '[S]'     | return s:modeColorHL('FTSearch') |
  else                         | return s:modeColorHL('Normal')   |
  endif
endfunction

"" Command functions
function! s:mcCmdExtraHL(group) abort
  if !hlID(a:group)
    return
  endif
  if exists('s:mc_timer')
    call timer_pause(s:mc_timer, 1)
    exe "silent hi" s:modecolor_main s:HLGroupMain
  endif
  let s:ExtraColorstring = s:getHLString(a:group)
  if !empty(s:ExtraColorstring)
    exe "silent hi" s:modecolor_extra s:ExtraColorstring
    if exists('s:MainColorstring')
      exe "silent hi" s:modecolor_main s:MainColorstring
    endif
  endif
endfunction

function! s:mcCmdMainHL(group) abort
  if !hlID(a:group)
    return
  endif
  if exists('s:mc_timer')
    call timer_pause(s:mc_timer, 1)
    exe "silent hi" s:modecolor_extra s:HLGroupExtra
  endif
  let s:MainColorstring = s:getHLString(a:group)
  if !empty(s:MainColorstring)
    exe "silent hi" s:modecolor_main s:MainColorstring
    if exists('s:ExtraColorstring')
      exe "silent hi" s:modecolor_extra s:ExtraColorstring
    endif
  endif
endfunction

function! s:mdCmdAllHL(group = '') abort
  if !hlID(a:group)
    return
  endif
  if exists('s:mc_timer')
    call timer_pause(s:mc_timer, 1)
  endif
  if empty(a:group)
    call s:mcCmdExtraHL(s:modecolor_extra)
    call s:mcCmdMainHL(s:modecolor_base)
  endif
  let s:MainColorstring = s:getHLString(a:group)
  let s:ExtraColorstring = s:MainColorstring
  if !empty(s:MainColorstring)
    exe "silent hi" s:modecolor_main s:MainColorstring
    exe "silent hi" s:modecolor_extra s:ExtraColorstring
  endif
endfunction

function! s:mcToggle()
  if ! exists('s:mc_timer')
    if g:modecolor_timer_switch == 0
      let g:modecolor_timer_switch = 1
      call s:modeColorStart()
    endif
    return
  endif
  if timer_info(s:mc_timer)[0]['paused']
    call timer_pause(s:mc_timer, '0')
  elseif s:mc_timer
    call timer_pause(s:mc_timer, '1')
    silent! s:modeColorInit()
    call s:modeColorHL('Normal')
  endif
endfunction

function! s:mcOn()
  if ! exists('s:mc_timer')
    if g:modecolor_timer_switch == 0
      let g:modecolor_timer_switch = 1
      call s:modeColorStart()
    endif
    return
  endif
  call timer_pause(s:mc_timer, '0')
endfunction

function! s:mcOff()
  call timer_pause(s:mc_timer, '1')
  exe "silent hi" s:modecolor_extra s:HLGroupExtra
  exe "silent hi" s:modecolor_main  s:HLGroupMain
endfunction

" Usage: ModeColorExtra [HLGroup]
" deactivate auto switch, force a color on
" `s:modecolor_extra` and `s:modecolor_base`

"" Starter
function! s:modeColorStart() abort
  if g:modecolor_timer_switch == 0
    call s:modeColorHL('Normal')
  elseif exists('timer_info(s:mc_timer)') <= 0
    let Switcher = function('s:mcSwitch')
    let s:mc_timer = timer_start(g:modecolor_refresh_time, Switcher, {'repeat': -1})
  endif
endfunction

if exists('s:mc_timer')
  call timer_stop(s:mc_timer)
  if s:HLGroupMain != ''
    silent exe "hi" s:modecolor_extra s:HLGroupExtra
  endif
  call s:modeColorStart()
endif

function! s:modeColorInit() abort
  call s:setHLDic()
  call s:setExtraStrings()
  call s:highlightUserGroups()
endfunction
call s:modeColorInit()


"" Autocommands
if has("nvim")
  augroup NvimColorAu
    au!
    au ColorScheme *
          \ call s:modeColorInit()
    au InsertEnter *
          \ call s:modeColorHL('Insert')
    au CmdlineEnter *
          \ call s:modeColorHL('Cmd')
  augroup END
endif

augroup StartModeColor
  au!
  au ColorScheme *
        \ call s:modeColorInit()
  au BufWinEnter ?\+ ++once
        \ call s:modeColorStart()
  au WinEnter *
        \ call s:modeColorHL('Normal')
augroup end
"" Commands
command! -nargs=? -complete=highlight ModeColorExtra
      \ call s:mcCmdExtraHL(<q-args>)
command! -nargs=? -complete=highlight ModeColorMain
      \ call s:mcCmdMainHL(<q-args>)
command! -nargs=? -complete=highlight ModeColorAll
      \ call s:mdCmdAllHL(<q-args>)

command! -nargs=0 ModeColortoggle call s:mcToggle()
command! -nargs=0 ModeColoron     call s:mcOn()
command! -nargs=0 ModeColoroff    call s:mcOff()

silent! noremap <silent> <unique> <script> <plug>(modeColorToggle)
      \ :set lz<cr>:call <sid>mcToggle()<cr>:set nolz<cr>
silent! noremap <silent> <unique> <script> <plug>(modeColorOff)
      \ :set lz<cr>:call <sid>mcOff()<cr>:set nolz<cr>
silent! noremap <silent> <unique> <script> <plug>(modeColorOn)
      \ :set lz<cr>:call <sid>moOn()<cr>:set nolz<cr>

if !hasmapto('<plug>modeColorToggle') && maparg('yom', 'n') ==# ''
  nmap yom <plug>modeColorToggle
endif
if !hasmapto('<plug>modeColorOn') && maparg('yom', 'n') ==# ''
  nmap [om <plug>modeColorOn
endif
if !hasmapto('<plug>modeColorOff') && maparg('yom', 'n') ==# ''
  nmap ]om <plug>modeColorOff
endif
