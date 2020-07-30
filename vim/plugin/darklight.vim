if exists('g:plugin_darklight')
  finish
endif
let g:plugin_darklight = 1

let g:dls_theme_force_load_start = get(g:, 'dls_theme_force_load_start', 'base16-onedark')
let g:dls_theme_source_sensitive = get(g:, 'dls_theme_source_sensitive', '0')
let g:dls_daytime = get(g:, 'dls_daytime', '[7, 19]')

function! SelectColorScheme() abort
  if g:dls_theme_force_load_start != '0'
    if index(g:dls_theme_list, g:dls_theme_force_load_start) >= 0
      exe "colorscheme" g:dls_theme_force_load_start
    else
      echom "Auto theme not found:" g:dls_theme_force_load_start . ". Using default:" g:dls_theme_list[0]. "."
      exe "colorscheme" g:dls_theme_list[0]
    endif
    unlet g:dls_theme_force_load_start
  else
    let hour = strftime("%H")
    if g:dls_daytime[0] <= hour && hour <= g:dls_daytime[1]
      exe "colorscheme" g:dls_theme_list[1]
    else
      exe "colorscheme" g:dls_theme_list[2]
    endif
  endif
endfunction
if ! exists("s:theme_change")
  call SelectColorScheme()
endif
if g:dls_theme_source_sensitive == 1
  call SelectColorScheme()
endif

function! DarkLightSwitch() abort
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
  let s:theme_change = 1
endfunction
