setlocal colorcolumn=0
setlocal nolist
setlocal nocursorline
setlocal textwidth=0
setlocal norelativenumber
setlocal showbreak=
setlocal wrap

nnoremap <buffer> <silent> <cr> <cr>

nnoremap <buffer> j <c-n>
nnoremap <buffer> k <c-p>

" Quickfix window height auto adjust if too big
function! s:adjustWindowHeight(minheight, maxheight)
  let l = 1
  let n_lines = 0
  let w_width = winwidth(0)
  while l <= line('$')
    " number to float for division
    let l_len = strlen(getline(l)) + 0.0
    let line_width = l_len/w_width
    let n_lines += float2nr(ceil(line_width))
    let l += 1
  endw
  exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" auto adjust height if not a vertical split (hopefuly)
if winheight('quickfix') < &lines - 5
  call s:adjustWindowHeight(1, 5)
endif

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
if ! empty('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
endif
let b:undo_ftplugin .= "setlocal colorcolumn< list< cursorline< textwidth< relativenumber< showbreak< wrap<"
