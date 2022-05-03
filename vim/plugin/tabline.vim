if exists('g:plugin_tabline')
  finish
endif
let g:plugin_tabline = 1

let g:tl_tabsize       = get(g:, 'tl_tabsize',       30)
let g:tl_expand        = get(g:, 'tl_expand',        0)
let g:tl_tab_sep       = get(g:, 'tl_tab_sep',       '  ')
let g:tl_tab_margin    = get(g:, 'tl_tab_margin',    1)
let g:tl_rhs_margin    = get(g:, 'tl_rhs_margin',    1)
let g:tl_button_close  = get(g:, 'tl_button_close',  ' X ')
let g:tl_button_onetab = get(g:, 'tl_button_onetab', ' - ')
let g:tl_left_fill     = get(g:, 'tl_left_fill',     ' ')
let g:tl_right_fill    = get(g:, 'tl_right_fill',    ' ')
let g:tl_label_max     = get(g:, 'tl_label_max',     50)
let g:tl_dirbox_max    = get(g:, 'tl_dirbox_max',    15)
" let g:tl_tab_overflow  = get(g:, 'tl_tab_overflow',  '°')
let g:tl_tab_overflow  = get(g:, 'tl_tab_overflow',  '`')

" let s:expantab_mode_sep = get(g:, 'tl_tab_sep', '')
function! TabLine() abort
  let total_label_size = s:total_label_size()
  let [dirbox_label, dir_box_len] = s:get_dirbox()
  let button = s:get_button()
  let s = ''
  for i in range(tabpagenr('$'))
    let i = i + 1
    if i == tabpagenr()
      let s ..= '%#TabLineSel#'  " current tab
    else
      let s ..= '%#TabLine#'     " non-current tabs
    endif
    let s ..= '%' .. (i) .. 'T'  " tab number (mouse click)
    let s ..= s:tab_label(i, total_label_size, dir_box_len)     " tab label
  endfor
  let s ..= '%#TabLineFill#%T%=' " free space
  let s ..= dirbox_label           " current dir / git
  let s ..= button
  return s
endfunction

function! s:get_button() abort
  let button_close = g:tl_button_close
  let button_onetab = g:tl_button_onetab
  if exists("g:loaded_obsession") && ObsessionStatus() != ''
    let button_close = ObsessionStatus(' S ', ' X ')
    let button_onetab = ObsessionStatus(' S ', ' - ')
  endif
  let s = ""
  let s ..= tabpagenr('$') > 1
        \? '%1*%999X' .. button_close
        \: '%1*' .. button_onetab
  return s
endfunction

function! s:getname(v) abort
  let name = matchstr(bufname(a:v), '[^/]*$')
  let buftype = getbufvar(a:v, '&buftype')
  if buftype ==# 'terminal'
    let name = "[Term]"
  endif
  if strlen(name) !=# ''
    return name[:g:tl_label_max]
  endif
  if name != ''
    return name[:g:tl_label_max]
  endif
  if buftype !=# ''
    let name = printf("[%s]", buftype[:g:tl_label_max - 2])
  else
    let name = printf("[%s]", "No Name"[:g:tl_label_max - 2])
  endif
  return name
endfunction

function! s:total_label_size() abort
  let lst_label_size = range(1, tabpagenr('$'))->map({
        \  _, v -> tabpagebuflist(v)->map({
        \    _, v -> s:getname(v)->len()
        \  })->max()
        \})->map({
        \  _, v -> v < g:tl_tabsize ? g:tl_tabsize : v
        \})
  let total_label_size = 0
  for size in lst_label_size
    let total_label_size += size + strchars(g:tl_tab_sep)
  endfor
  let total_label_size -= strchars(g:tl_tab_sep)
  return total_label_size
endfunction

function! s:reduce_sep(total_used_space) abort
  let sep = g:tl_tab_sep
  let sep_len = strchars(sep)
  let total_used_space = a:total_used_space
  let i = 0
  while total_used_space > &columns && strchars(sep) > 1
    let sep = sep[:-2]
    let total_used_space -= tabpagenr('$')
  endwhile
  return sep
endfunction

function! s:is_tab_overflow(total_label_size, dir_box_len) abort
  let needed_space = a:total_label_size + a:dir_box_len + strchars(g:tl_button_close) + 1
  return needed_space > &columns
endfunction

function! s:is_label_overflow(label, tab_size, padd) abort
  return strchars(a:label) > a:tab_size - 2 * a:padd
endfunction

function! s:get_left_padding(tab_size, label) abort
  return max([(a:tab_size - strchars(a:label)) / 2, 1])
endfunction

function! s:get_overflow_tab_size(reserved_space) abort
  let tab_size = (
        \&columns
        \- a:reserved_space
        \- strchars(g:tl_button_close)
        \- strchars(g:tl_tab_sep) * (tabpagenr('$') - 1)
        \)
        \/ tabpagenr('$')
  return tab_size
endfunction

function! s:tab_label(index, total_label_size, dir_box_len) abort
  let label = s:label_text(a:index)
  let tab_size = tabpagebuflist(a:index)->map({
        \  _, v -> s:getname(v)->len()
        \})->max()
  let tab_size = max([tab_size, g:tl_tabsize]) + strchars(g:tl_tab_sep)
  let left_padding = s:get_left_padding(tab_size, label)

  if s:is_tab_overflow(a:total_label_size, a:dir_box_len) || g:tl_expand
    let label = s:label_text(a:index)
    let tab_size = s:get_overflow_tab_size(a:dir_box_len)
    let left_padding = s:get_left_padding(tab_size, label)
    if s:is_label_overflow(label, tab_size, 1)
      let label = label[:tab_size - 3] .. g:tl_tab_overflow
      let tab_size -= 1
      let left_padding = 1
    endif
  endif
  let left_padstring = repeat(g:tl_left_fill, left_padding)
  let right_padstring = repeat(g:tl_right_fill, tab_size - left_padding - strchars(label))
  let s = left_padstring . label . right_padstring
  if a:index < tabpagenr('$')
    let s ..= '%#TabLineFill#' .. g:tl_tab_sep
  endif
  return s
endfunction

function! s:label_text(n) abort
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return s:getname(buflist[winnr - 1])
endfunction

function! s:get_dirbox_len() abort
  let dir_box_len = range(1, tabpagenr('$'))->map({
        \  _, v -> tabpagebuflist(v)->map({
        \    _, v -> s:get_dir_len(v)
        \  })->max()
        \})->max()
  return min([dir_box_len + 2 * g:tl_rhs_margin, g:tl_dirbox_max])
endfunction

function! s:get_dir_len(dir) abort
  let buf = bufname(a:dir)
  if getbufvar(buf, '&buftype') !=# ''
    return 0
  endif
  if exists('*FugitiveGitDir()') && FugitiveExtractGitDir(buf) != ''
    if matchstr(FugitiveExtractGitDir(buf), ".*/\.git$") != ''
      let dir = matchstr(FugitiveExtractGitDir(buf), "[^/]*\\ze/\.git$")
    else
      let dir = matchstr(FugitiveExtractGitDir(buf), "[^/]*$")
    endif
  else
    let dir = matchstr(buf, "[^/]*\\ze/[^/]*$")
  endif
  return min([len(dir), g:tl_dirbox_max])
endfunction

function! s:get_dirbox() abort
  let dirbox_str = ''
  let dirbox_len = s:get_dirbox_len()
  if exists('*FugitiveGitDir()') && FugitiveWorkTree() != ''
    let dirbox_str ..= isdirectory('.git') ? '%7*' : '%8*'    " submodule?
    let dirbox_label = matchstr(FugitiveWorkTree(), "[^/]*$")
  else
    let dirbox_str ..= '%3*'
    let dirbox_label = matchstr(getcwd(), "[^/]*$")
    if strchars(dirbox_label) > g:tl_dirbox_max
      let dirbox_label = dirbox_label[:g:tl_dirbox_max - 2] .. g:tl_tab_overflow
    endif
  endif
  if dirbox_len == 2 * g:tl_rhs_margin
    let dirbox_len += strlen(dirbox_label)
  endif
  let padd = (dirbox_len - strchars(dirbox_label)) / 2
  let dirbox_str ..= repeat(' ', padd)
  let dirbox_str ..= dirbox_label
  let dirbox_str ..= repeat(' ', dirbox_len - strchars(dirbox_label) - padd)
  let dirbox_str ..= '%*'
  return [dirbox_str, dirbox_len]
endfunction

set tabline=%!TabLine()
