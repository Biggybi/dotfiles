" Courtesy of Andy 'Airblade' Stewart
" https://github.com/airblade/vim-current-search-match

if exists('g:plugin_search') || !exists('*matchstrpos')
  finish
endif
let g:plugin_search = 1

" let g:search_count_update = ':AnzuUpdateSearchStatus'
let g:current_search_match = get(g:, 'current_search_match', 'IncSearch')
let g:edge_search_match = get(g:, 'edge_search_match', 'EdgeSearch')
let g:search_count_update = get(g:, 'search_count_update', '')

let s:pos = []
let s:match = 0
let s:nomatch = [0, 0]

function! s:is_highlighting_search()
  return &hlsearch && v:hlsearch
endfunction

function! s:delete_current_match()
  if !s:match | return | endif
  let winid = s:pos[3]
  if winbufnr(winid) == -1 | return | endif
  if has('patch-8.1.1084') || has('nvim-0.5.0')
    try | call matchdelete(s:match, winid) | catch /^Vim\%((\a\+)\)\=:E803:/ | endtry
  else
    let same_win = winid == win_getid()
    if !same_win | noautocmd call win_gotoid(winid) | endif
    try | call matchdelete(s:match) | catch /^Vim\%((\a\+)\)\=:E803:/ | endtry
    if !same_win | noautocmd wincmd p | endif
  endif
endfunction

" Returns [start, stop] if the cursor is in a search match, where start and
" stop are column numbers, or s:nomatch if the cursor is not in a search match.
"
" Note: for matchstrpos() (from docs for match()):
"
"   The 'ignorecase' option is used to set the ignore-caseness of
"   the pattern.  'smartcase' is NOT used.  The matching is always
"   done like 'magic' is set and 'cpoptions' is empty.
"
function! s:cursor_in_search_match(...)
  if !s:is_highlighting_search() | return s:nomatch | endif
  let [match, start, stop] = matchstrpos(getline('.'), @/, (a:0 ? a:1 : 0))
  if empty(match) | return s:nomatch | endif
  let col = getcurpos()[2]
  if col <= start | return s:nomatch | endif
  if col <= stop
    if exists(g:search_count_update)
      exe g:search_count_update
    endif
    return [start, stop]
  endif
  return s:cursor_in_search_match(stop)
endfunction

function! s:update_search_match()
  let [start, stop] = s:cursor_in_search_match()
  if [start, stop] != s:nomatch
    let line = line('.')
    let window = win_getid()
    if s:pos != [start, stop, line, window]
      call s:delete_current_match()
      if search(@/, 'bWn') == 0 || search(@/, 'Wn') == 0
        let s:match = matchaddpos(g:edge_search_match, [[line, start+1, stop-start]])
      else
        let s:match = matchaddpos(g:current_search_match, [[line, start+1, stop-start]])
      endif
      let s:pos = [start, stop, line, window]
    endif
  else
    call s:delete_current_match()
    let s:match = 0
    let s:pos = []
  endif
endfunction

command! UpdateSearchMatch :call s:update_search_match()

function s:toggleHL()
  if &hls && v:hlsearch
    echo "hlsearch off"
    return "nohls"
  else
    echo "nohlsearch on"
    return "set hls"
  endif
endfunction

command! ToggleHL :exe s:toggleHL()

nnoremap <expr> <plug>ToggleHL <sid>toggleHL()
if !hasmapto('<plug>ToggleHL') && maparg('yoh', 'n') ==# ''
  nmap yoh <plug>ToggleHL
endif

augroup Current_search_match
  autocmd!
  autocmd CursorMoved * silent! call s:update_search_match()
  if exists(':AnzuClearSearchStatus')
    autocmd WinLeave * :AnzuClearSearchStatus
  endif
augroup end
