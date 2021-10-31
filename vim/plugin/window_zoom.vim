if exists('g:plugin_window_zoom')
  finish
endif
let g:plugin_window_zoom = 1

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction

command! ZoomToggle call s:ZoomToggle()
nnoremap <expr> <plug>Zoom <sid>ZoomToggle()

if !hasmapto('<plug>Zoom') && maparg('<c-w><c-o>', 'n') ==# ''
  nmap <c-w><c-o> <plug>Zoom
endif
if !hasmapto('<plug>Zoom') && maparg('<c-w>o', 'n') ==# ''
  nmap <c-w>o <plug>Zoom
endif
