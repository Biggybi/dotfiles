function! TabLine() abort
  let s = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s ..= '%#TabLineSel#'  " current tab
    else
      let s ..= '%#TabLine#'     " non-current tabs
    endif
    let s ..= '%' .. (i + 1) .. 'T' " tab number (mouse click)
    let s ..= ' %{TabLabel(' .. (i + 1) .. ')} ' " Label
    let s ..= '%#TabLineFill#  ' " tabs separation
  endfor
  let s ..= '%#TabLineFill#%T%=' " free space
  let s ..= '%{%TablineDir()%}'  " current dir / git
  if tabpagenr('$') > 1
    let s ..= '%1*%999X X '      " close button
  endif
  return s
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
