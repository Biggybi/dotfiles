if exists('g:plugin_tabline')
  finish
endif
let g:plugin_tabline = 1

let g:tabline_min_tab_size = get(g:, 'tabline_min_tab_size', 20)
let g:tabline_expand_tabs = get(g:, 'tabline_expand_tabs', 0)

function! TabLine() abort
  let tablinedir = TablineDir()
  let s = ''
  for i in range(tabpagenr('$'))
    let i = i + 1
    if i == tabpagenr()
      let s ..= '%#TabLineSel#'  " current tab
    else
      let s ..= '%#TabLine#'     " non-current tabs
    endif
    let s ..= '%' .. (i) .. 'T'  " tab number (mouse click)
    let s ..= s:tab_label(i)     " tab label
    let s ..= '%#TabLineFill#  ' " tabs separation
  endfor
  let s ..= '%#TabLineFill#%T%=' " free space
  let s ..= tablinedir           " current dir / git
  let s ..= tabpagenr('$') > 1
        \?'%1*%999X X '
        \:'%1* - '
  return s
endfunction

function! s:tab_label(index)
  let label = s:label_text(a:index)
  let lab_size = tabpagebuflist(a:index)->map({
        \_, v -> bufname(v)->matchstr('[^/]*$')->len()
        \})->max() + 2
  let lab_size = max([lab_size, g:tabline_min_tab_size])
  let is_too_wide = (lab_size) * tabpagenr('$') > &columns
  if g:tabline_expand_tabs || is_too_wide
    let lab_size = (&columns - 20) / tabpagenr('$')
    echo lab_size
  endif
  let padding = max([(lab_size - label->len()) / 2, 1])
  let padstring = repeat(' ', padding)
  return padstring . label . padstring
endfunction

function! s:label_text(n) abort
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return matchstr(bufname(buflist[winnr - 1]), '[^/]*$')
endfunction

function! TablineDir() abort
  if exists('*FugitiveGitDir()') && FugitiveGitDir() != ''
    let s = ''
    let s ..= isdirectory('.git') ? '%7* ' : '%8* '
    let s ..= matchstr(FugitiveWorkTree(), "[^/]*$")
    let s ..= ' %*'
    return s
  endif
  return '%3* ' .. matchstr(expand("%:p:h"), "[^/]*$") .. ' %*'
endfunction

set tabline=%!TabLine()
