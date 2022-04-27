function! TabLine() abort
  let s = ''
  for i in range(tabpagenr('$'))
    let i = i + 1
    if i == tabpagenr()
      let s ..= '%#TabLineSel#'  " current tab
    else
      let s ..= '%#TabLine#'     " non-current tabs
    endif
    let s ..= '%' .. (i) .. 'T' " tab number (mouse click)
    let label = TabLabel(i)
    let [lab_size, padding] = s:tablab_size(i, label)
    let s ..= '%-' .. lab_size .. '.' .. lab_size . '(' .. repeat(' ', padding) .. label .. '%)' " Label
    let s ..= '%#TabLineFill#  ' " tabs separation
  endfor
  let s ..= '%#TabLineFill#%T%=' " free space
  let s ..= '%{%TablineDir()%}'  " current dir / git
  if tabpagenr('$') > 1
    let s ..= '%1*%999X X '      " close button
  else
    let s ..= '%1* - '
  endif
  return s
endfunction

function! s:tablab_size(index, label)
  let lab_size = tabpagebuflist(a:index)->map({
        \_, v -> bufname(v)->matchstr('[^/]*$')->len()
        \})->max() + 2
  let padding = (lab_size - a:label->len()) / 2
  return [lab_size, padding]
endfunction

function! TabLabel(n) abort
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
