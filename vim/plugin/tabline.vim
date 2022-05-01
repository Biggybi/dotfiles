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
let g:tabline_label_overflow_char = get(g:, 'tabline_label_overflow_char', '|')

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
  " let s:expantab_mode_sep = get(g:, 'tabline_tab_sep', '')
  let s ..= '%#TabLineFill#%T%<%=' " free space
  let s ..= tablinedir           " current dir / git
  let s ..= tabpagenr('$') > 1
        \? '%1*%999X' . g:tabline_close_button
        \: '%1*' . g:tabline_dummy_close_button
  return s
endfunction

function! s:getname(v) abort
  let name = matchstr(bufname(a:v), '[^/]*$')[:g:tabline_label_max_size]
  if name !=# '' | return name | endif
  return printf("[%s]", getbufvar(a:v, '&buftype')[:g:tabline_label_max_size])
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

function! s:tab_label(index, total_label_size, dir_box_len) abort
  let label = s:label_text(a:index)
  let tab_size = tabpagebuflist(a:index)->map({
        \_, v -> s:getname(v)->len()
        \})->max()
  let tab_size = max([tab_size, g:tabline_min_tab_size]) + len(g:tabline_tab_sep)

  if g:tabline_expand_tabs
    let label = s:label_text(a:index)
    let tab_size = (&columns - a:dir_box_len - len(g:tabline_close_button) - len(g:tabline_tab_sep) * tabpagenr('$')) / tabpagenr('$')
    if len(label) > tab_size - 2
      let total_used_space = a:total_label_size + a:dir_box_len + len(g:tabline_close_button)
      let sep = s:reduce_sep(total_used_space)
      let label = label[:tab_size - 2 - len(sep)] .. '`'
      let padding = 1
      let tab_size = (&columns - a:dir_box_len - len(g:tabline_close_button) - len(sep) * (tabpagenr('$'))) / tabpagenr('$')
      let left_padstring = repeat(g:tabline_left_fill_char, padding)
      let right_padstring = repeat(g:tabline_right_fill_char, tab_size - padding - len(label))
      let s = left_padstring . label . right_padstring
      if a:index < tabpagenr('$')
        let s ..= '%#TabLineFill#' .. sep
      endif
      return s
    endif
    let left_padding = max([(tab_size - len(label)) / 2, 1])
  elseif a:total_label_size + a:dir_box_len + len(g:tabline_close_button) > &columns
    let label = s:label_text(a:index)
    let tab_size = (&columns - a:dir_box_len - len(g:tabline_close_button) - len(g:tabline_tab_sep) * tabpagenr('$')) / tabpagenr('$')
    if len(label) > tab_size - 2
      let label = label[:tab_size - 2] .. '`'
      let left_padding = 1
      let tab_size = len(label) + 2
    else
      let left_padding = max([((tab_size - len(label) - 1)) / 2, 1])
    endif
  else
    let left_padding = max([(tab_size - len(label)) / 2, 1])
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
  if exists('*FugitiveGitDir()') && FugitiveGitDir(a:dir) != ''
    return matchstr(FugitiveGitDir(a:dir), "[^/]*$")->len()
  endif
  let dir_len = len(matchstr(expand("%:p:h"), "[^/]*$"))
  return dir_len
endfunction

function! s:tablineDir(dir_box_len) abort
  let s = ''
  if exists('*FugitiveGitDir()') && FugitiveGitDir() != ''
    let s ..= isdirectory('.git') ? '%7*' : '%8*'    " submodule?
    let label = matchstr(FugitiveWorkTree(), "[^/]*$")
  else
    let s ..= '%3*'
    let label = matchstr(expand("%:p:h"), "[^/]*$")
  endif
  let padd = (a:dir_box_len - len(label)) / 2
  let s ..= repeat(' ', padd)
  let s ..= label
  let s ..= repeat(' ', a:dir_box_len - len(label) - padd)
  let s ..= '%*'
  return s
endfunction

set tabline=%!TabLine()
