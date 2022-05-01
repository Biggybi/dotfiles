if exists('g:plugin_tabline')
  finish
endif
let g:plugin_tabline = 1

let g:tabline_min_tab_size = get(g:, 'tabline_min_tab_size', 30)
let g:tabline_expand_tabs = get(g:, 'tabline_expand_tabs', 0)
let g:tabline_tab_sep = get(g:, 'tabline_tab_sep', '  ')
let g:tabline_tab_margin = get(g:, 'tabline_tab_margin', 1)
let g:tabline_rhs_margin = get(g:, 'tabline_rhs_margin', 1)
let g:tabline_close_button = get(g:, 'tabline_close_button', ' X ')
let g:tabline_dummy_close_button = get(g:, 'tabline_dummy_close_button', ' - ')
let g:tabline_left_fill_char = get(g:, 'tabline_left_fill_char', ' ')
let g:tabline_right_fill_char = get(g:, 'tabline_right_fill_char', ' ')
let g:tabline_label_max_size = get(g:, 'tabline_label_max_size', 50)
let g:tabline_dirbox_max_size = get(g:, 'tabline_dirbox_max_size', 15)
let g:tabline_label_overflow_char = get(g:, 'tabline_label_overflow_char', '`')

" let s:expantab_mode_sep = get(g:, 'tabline_tab_sep', '')
function! TabLine() abort
  let total_label_size = s:total_label_size()
  let dir_box_len = s:get_folder_tab_len()
  let tablinedir = s:tablineDir(dir_box_len)
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
  let s ..= tablinedir           " current dir / git
  let s ..= tabpagenr('$') > 1
        \? '%1*%999X' . g:tabline_close_button
        \: '%1*' . g:tabline_dummy_close_button
  return s
endfunction

function! s:getname(v) abort
  let buftype = getbufvar(a:v, '&buftype')
  if buftype ==# 'terminal'
    let name = "[Term]"
  else
    let name = matchstr(bufname(a:v), '[^/]*$')
  endif
  if name ==# ''
    return printf("[%s]", buftype[:g:tabline_label_max_size])
  endif
  return name[:g:tabline_label_max_size]
endfunction

function! s:total_label_size() abort
  let lst_label_size = range(1, tabpagenr('$'))->map({
        \  _, v -> tabpagebuflist(v)->map({
        \    _, v -> s:getname(v)->len()
        \  })->max()
        \})->map({
        \  _, v -> v < g:tabline_min_tab_size ? g:tabline_min_tab_size : v
        \})
  let total_label_size = 0
  for size in lst_label_size
    let total_label_size += size + g:tabline_tab_margin * 2 + len(g:tabline_tab_sep)
  endfor
  let total_label_size -= len(g:tabline_tab_sep)
  return total_label_size
endfunction

function! s:reduce_sep(total_used_space) abort
  let sep = g:tabline_tab_sep
  let sep_len = len(sep)
  let total_used_space = a:total_used_space
  let i = 0
  while total_used_space > &columns && len(sep) > 1
    let sep = sep[:-2]
    let total_used_space -= tabpagenr('$')
  endwhile
  return sep
endfunction

function! s:is_tab_overflow(total_label_size, dir_box_len) abort
  let needed_space = a:total_label_size + a:dir_box_len + len(g:tabline_close_button)
  return needed_space > &columns
endfunction

function! s:is_label_overflow(label, tab_size, padd) abort
  return len(a:label) > a:tab_size - 2 * a:padd
endfunction

function! s:get_left_padding(tab_size, label) abort
  return max([(a:tab_size - len(a:label)) / 2, 1])
endfunction

function! s:get_overflow_tab_size(reserved_space) abort
  let tab_size = (
        \&columns
        \- a:reserved_space
        \- len(g:tabline_close_button)
        \- len(g:tabline_tab_sep) * (tabpagenr('$') - 1)
        \)
        \/ tabpagenr('$')
  return tab_size
endfunction

function! s:tab_label(index, total_label_size, dir_box_len) abort
  let label = s:label_text(a:index)
  let tab_size = tabpagebuflist(a:index)->map({
        \  _, v -> s:getname(v)->len()
        \})->max()
  let tab_size = max([tab_size, g:tabline_min_tab_size]) + len(g:tabline_tab_sep)
  let left_padding = s:get_left_padding(tab_size, label)

  if s:is_tab_overflow(a:total_label_size, a:dir_box_len) || g:tabline_expand_tabs
    let label = s:label_text(a:index)
    let tab_size = s:get_overflow_tab_size(a:dir_box_len)
    let left_padding = s:get_left_padding(tab_size, label)
    if s:is_label_overflow(label, tab_size, 1)
      let label = label[:tab_size - 3] .. g:tabline_label_overflow_char
      let tab_size -= 1
      let left_padding = 1
    endif
  endif
  let left_padstring = repeat(g:tabline_left_fill_char, left_padding)
  let right_padstring = repeat(g:tabline_right_fill_char, tab_size - left_padding - len(label))
  let s = left_padstring . label . right_padstring
  if a:index < tabpagenr('$')
    let s ..= '%#TabLineFill#' .. g:tabline_tab_sep
  endif
  return s
endfunction

function! s:label_text(n) abort
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return s:getname(buflist[winnr - 1])
endfunction

function! s:get_folder_tab_len() abort
  let dir_box_len = range(1, tabpagenr('$'))->map({
        \  _, v -> tabpagebuflist(v)->map({
        \    _, v -> s:get_dir_len(v)
        \  })->max()
        \})->max()
  return dir_box_len + 2 * g:tabline_rhs_margin
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
  return min([len(dir), g:tabline_dirbox_max_size])
endfunction

function! s:tablineDir(dir_box_len) abort
  let s = ''
  if exists('*FugitiveGitDir()') && FugitiveWorkTree() != ''
    let s ..= isdirectory('.git') ? '%7*' : '%8*'    " submodule?
    let label = matchstr(FugitiveWorkTree(), "[^/]*$")
  else
    let s ..= '%3*'
    let label = matchstr(expand("%:p:h"), "[^/]*$")
    if len(label) > g:tabline_dirbox_max_size
      let label = label[:g:tabline_dirbox_max_size - 2] .. g:tabline_tab_overflow_char
    endif
  endif
  let padd = (a:dir_box_len - len(label)) / 2
  let s ..= repeat(' ', padd)
  let s ..= label
  let s ..= repeat(' ', a:dir_box_len - len(label) - padd)
  let s ..= '%*'
  return s
endfunction

set tabline=%!TabLine()
