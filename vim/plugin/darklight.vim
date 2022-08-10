if exists('g:plugin_darklight')
  finish
endif
let g:plugin_darklight = 1

let g:dls_current_theme = get(g:, 'dls_start_theme_index', '/home/tris/.config/base16_theme')

let g:dls_start_theme_index = get(g:, 'dls_start_theme_index', '0')
let g:dls_theme_source_sensitive = get(g:, 'dls_theme_source_sensitive', '0')
let g:dls_theme_shell_sensitive = get(g:, 'dls_theme_shell_sensitive', '0')

let g:dls_daytime = get(g:, 'dls_daytime', '[7, 19]')

let s:dls_theme_list = get(g:, 'dls_theme_list', [
      \'onehalfdarkest',
      \'onehalfdarker',
      \'onehalfdark',
      \'onehalflightdim',
      \'onehalflight'
      \])

let g:dls_night = get(g:, 'dls_night', s:dls_theme_list[0])
let g:dls_day   = get(g:, 'dls_day', s:dls_theme_list[-1])

function! s:buildThemeList() abort
  let theme_number = len(s:dls_theme_list) - 1
  for i in reverse(range(1, theme_number - 1))
    call add(s:dls_theme_list, s:dls_theme_list[i])
  endfor
endfunction

call s:buildThemeList()

function! s:setTheme(theme) abort
  try
    exe "colorscheme" a:theme
  catch /^Vim\%((\a\+)\)\=:E185/
  endtry
endfunction

function! s:shellThemeDetect() abort
  if !file_readable(expand('$HOME/.config/base16_theme'))
    return 0
  endif
  let base16_theme=get(readfile(expand('$HOME/.config/base16_theme'), '', 1), 0)
  if (base16_theme == "")
    return 0
  endif
  exe "colorscheme" base16_theme
  return 1
endfunction

function! s:selectColorScheme() abort
  if s:shellThemeDetect() != 0
    return
  endif
  if g:dls_start_theme_index != 0
    if index(s:dls_theme_list, g:dls_start_theme_index) >= 0
      call s:setTheme(g:dls_start_theme_index)
    else
      echom "Auto theme not found:" g:dls_start_theme_index .
            \ ". Using default:" s:dls_theme_list[0]. "."
      call s:setTheme(s:dls_theme_list[g:dls_start_theme_index])
    endif
    unlet g:dls_start_theme_index
  else
    let hour = strftime("%H")
    if g:dls_daytime[0] <= hour && hour < g:dls_daytime[1]
      call s:setTheme(g:dls_day)
    else
      call s:setTheme(g:dls_night)
    endif
  endif
endfunction

function! s:darkLightSwitch() abort
  if ! exists('s:theme_index')
    let s:theme_index = index(s:dls_theme_list, g:colors_name)
  endif
  let s:theme_index += 1
  if s:theme_index == len(s:dls_theme_list)
    let s:theme_index = 0
  endif
  exe "colorscheme" s:dls_theme_list[s:theme_index]
endfunction

function! s:applyScheme(scheme)
  if index(s:dls_theme_list, a:scheme) < 0
    echom "Auto theme not found:" a:scheme . "."
    return
  endif
  exe "colorscheme" a:scheme
endfunction

command! DarkLightSwitch call s:darkLightSwitch()
command! -nargs=? -complete=color DarkLightNight
      \ if expand('<args>') !=# ''
        \ | let g:dls_night = expand('<args>')
        \ | endif
      \ | call s:applyScheme(g:dls_night)
command! -nargs=? -complete=color DarkLightDay
      \ if expand('<args>') !=# ''
        \ | let g:dls_day = expand('<args>')
        \ | endif
      \ | call s:applyScheme(g:dls_day)

nnoremap <expr> <plug>DarkLightSwitch <sid>darkLightSwitch()
nnoremap <expr> <plug>DarkLightNight  <sid>applyScheme(g:dls_night)
nnoremap <expr> <plug>DarkLightDay    <sid>applyScheme(g:dls_day)

if !hasmapto('<plug>DarkLightSwitch') && maparg('yob', 'n') ==# ''
  nmap yob <plug>DarkLightSwitch
endif
if !hasmapto('<plug>DarkLightNight') && maparg('[ob', 'n') ==# ''
  nmap [ob <plug>DarkLightNight
endif
if !hasmapto('<plug>DarkLightDay') && maparg(']ob', 'n') ==# ''
  nmap ]ob <plug>DarkLightDay
endif

if ! exists("s:theme_change")
  call s:selectColorScheme()
  let s:theme_change = 1
endif

augroup LumenDarkLight
  au!
  autocmd User LumenLight DarkLightDay
  autocmd User LumenDark  DarkLightNight
augroup end

function s:syncTmuxTheme(_)
  if (filereadable(expand('$HOME/.config/onehalftheme')))
    let theme=get(readfile(expand('$HOME/.config/onehalftheme'), '', 1), 0)
    if theme != g:colors_name
      call s:applyScheme(theme)
    endif
  endif
endfunction

let g:darklight_timer_delay = get(g:, 'darklight_timer_delay', '1')

let SyncTmuxTheme = function('s:syncTmuxTheme')
let s:darklight_timer = timer_start(g:darklight_timer_delay, SyncTmuxTheme, {'repeat': -1})
