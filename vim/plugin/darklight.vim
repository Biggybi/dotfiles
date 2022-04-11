if exists('g:plugin_darklight')
  finish
endif
let g:plugin_darklight = 1

let g:dls_start_theme_index = get(g:, 'dls_start_theme_index', '0')
let g:dls_theme_source_sensitive = get(g:, 'dls_theme_source_sensitive', '0')

let g:dls_daytime = get(g:, 'dls_daytime', '[7, 19]')

let s:dls_theme_list = get(g:, 'dls_theme_list', [
      \get(g:, 'dls_color_0', 'base16-onedarker'),
      \get(g:, 'dls_color_1', 'base16-onedark'),
      \get(g:, 'dls_color_2', 'base16-one-lightdim'),
      \get(g:, 'dls_color_3', 'base16-one-light')
      \])

let g:dls_night = get(g:, 'dls_night', s:dls_theme_list[0])
let g:dls_day   = get(g:, 'dls_day', s:dls_theme_list['$'])

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

function! s:selectColorScheme() abort
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

if ! exists("s:theme_change")
  call s:selectColorScheme()
  let s:theme_change = 1
endif
if g:dls_theme_source_sensitive == 1
  call s:selectColorScheme()
endif

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

function! s:darkLightNight()
  call s:applyScheme(get(s:dls_theme_list, '0'))
endfunction

function! s:darkLightDay()
  call s:applyScheme(get(s:dls_theme_list, '-3'))
endfunction

command! DarkLightSwitch :call s:darkLightSwitch()
command! DarkLightNight  :call s:darkLightNight()
command! DarkLightDay    :call s:darkLightDay()

nnoremap <expr> <plug>DarkLightSwitch <sid>darkLightSwitch()
nnoremap <expr> <plug>DarkLightNight  <sid>darkLightNight()
nnoremap <expr> <plug>DarkLightDay    <sid>darkLightDay()

if !hasmapto('<plug>DarkLightSwitch') && maparg('yob', 'n') ==# ''
  nmap yob <plug>DarkLightSwitch
endif
if !hasmapto('<plug>DarkLightNight') && maparg('[ob', 'n') ==# ''
  nmap [ob <plug>DarkLightNight
endif
if !hasmapto('<plug>DarkLightDay') && maparg(']ob', 'n') ==# ''
  nmap ]ob <plug>DarkLightDay
endif
