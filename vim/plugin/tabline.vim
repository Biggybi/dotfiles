if exists('g:plugin_tabline')
  finish
endif
let g:plugin_tabline = 1

let g:tabline_min_tab_size = get(g:, 'tabline_min_tab_size', 0)
let g:tabline_expand_tabs = get(g:, 'tabline_expand_tabs', 0)

function! TabLine() abort
  let total_label_size = s:total_label_size()
  let tablinedir = s:tablineDir()
  let right_side_len = len(tablinedir)
  let s = ''
  for i in range(tabpagenr('$'))
    let i = i + 1
    if i == tabpagenr()
      let s ..= '%#TabLineSel#'  " current tab
    else
      let s ..= '%#TabLine#'     " non-current tabs
    endif
    let s ..= '%' .. (i) .. 'T'  " tab number (mouse click)
    let s ..= s:tab_label(i, total_label_size, right_side_len)     " tab label
    let s ..= '%#TabLineFill#  ' " tabs separation
  endfor
  let s ..= '%#TabLineFill#%T%=' " free space
  let s ..= tablinedir           " current dir / git
  let s ..= tabpagenr('$') > 1
        \?'%1*%999X X '
        \:'%1* - '
  return s
endfunction

function! s:total_label_size() abort
  let lst_label_size = range(1, tabpagenr('$'))->map({
        \  _, v -> tabpagebuflist(v)->map({
        \    _, v -> bufname(v)->matchstr('[^/]*$')->len()
        \  })->max()
        \})->map({
        \  _, v -> v < g:tabline_min_tab_size ? g:tabline_min_tab_size : v
        \})
  let total_label_size = 0
  for size in lst_label_size
    let total_label_size += size + 4
  endfor
  let total_label_size -= 2
  return total_label_size
endfunction

function! s:tab_label(index, total_label_size, right_side_len) abort
  let label = s:label_text(a:index)
  let tab_size = tabpagebuflist(a:index)->map({
        \_, v -> bufname(v)->matchstr('[^/]*$')->len()
        \})->max()
  let tab_size = max([tab_size, g:tabline_min_tab_size]) + 2

  if g:tabline_expand_tabs || a:total_label_size > &columns
    let tab_size = (&columns - a:right_side_len - 2) / tabpagenr('$')
    let padding = max([((tab_size - label->len() - 1)) / 2, 1])
    let padstring = repeat(' ', padding)
    return padstring . label . padstring
  endif
  let left_padding = max([(tab_size - label->len()) / 2, 1])
  let left_padstring = repeat(' ', left_padding)
  echo tab_size left_padding
  let right_padstring = repeat(' ', tab_size - left_padding - len(label))
  return left_padstring . label . right_padstring
endfunction

function! s:label_text(n) abort
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return matchstr(bufname(buflist[winnr - 1]), '[^/]*$')
endfunction

function! s:tablineDir() abort
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
