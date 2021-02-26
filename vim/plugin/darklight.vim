if exists('g:plugin_darklight')
  finish
endif
let g:plugin_darklight = 1

let g:dls_theme_force_load_start = get(g:, 'dls_theme_force_load_start', '0')
let g:dls_theme_source_sensitive = get(g:, 'dls_theme_source_sensitive', '0')
let g:dls_daytime = get(g:, 'dls_daytime', '[7, 19]')

function! s:SelectColorScheme() abort
  if g:dls_theme_force_load_start != '0'
    if index(g:dls_theme_list, g:dls_theme_force_load_start) >= 0
      echo "colorscheme" g:dls_theme_force_load_start
      exe "colorscheme" g:dls_theme_force_load_start
    else
      echom "Auto theme not found:" g:dls_theme_force_load_start .
            \ ". Using default:" g:dls_theme_list[0]. "."
      exe "colorscheme" g:dls_theme_list[0]
    endif
    unlet g:dls_theme_force_load_start
  else
    let hour = strftime("%H")
    if g:dls_daytime[0] <= hour && hour < g:dls_daytime[1]
      echo "colorscheme" g:dls_theme_list[1]
      exe "colorscheme" g:dls_theme_list[1]
    else
      echo "colorscheme" g:dls_theme_list[2]
      exe "colorscheme" g:dls_theme_list[2]
    endif
  endif
endfunction

if ! exists("s:theme_change")
  call s:SelectColorScheme()
endif
if g:dls_theme_source_sensitive == 1
  call s:SelectColorScheme()
endif

function! s:DarkLightSwitch() abort
  if ! exists('s:theme_change')
    let s:theme_index = index(g:dls_theme_list, g:colors_name)
  endif
  if ! exists('s:theme_index')
    let s:theme_index = index(g:dls_theme_list, g:colors_name)
  endif
  let s:theme_index += 1
  if s:theme_index == len(g:dls_theme_list)
    let s:theme_index = 0
  endif
  exe "colorscheme" g:dls_theme_list[s:theme_index]
  echo "colorscheme" g:dls_theme_list[s:theme_index]
  let s:theme_change = 1
endfunction

function! s:ApplyScheme(scheme)
  if index(g:dls_theme_list, a:scheme) < 0
      echom "Auto theme not found:" a:scheme . "."
      return
  endif
  echo "coucou"
  exe "colorscheme" a:scheme
endfunction

command! DarkLightSwitch :call s:DarkLightSwitch()
command! DarkLightLast :call s:ApplyScheme(get(g:dls_theme_list, -2))
command! DarkLightFirst :call s:ApplyScheme(get(g:dls_theme_list, 0))
