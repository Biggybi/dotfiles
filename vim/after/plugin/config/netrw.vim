if ! exists(':Explore')
  finish
endif

" open netrw if vim starts without file
let g:netrw_startup = 0
let g:netrw_startup_no_file = 0
let g:netrw_home = "vim/tmp/plugin"

function! s:NetrwStartup() abort
  if (g:netrw_startup_no_file == 1 || g:netrw_startup == 1)
        \&& expand('%') == ''
    Ex
  elseif g:netrw_startup == 1
    Lexplore | wincmd w | endif
  endif
endfunction

augroup NetrwStartup
  au!
  au VimEnter * call <sid>NetrwStartup()
augroup end

augroup AutoDeleteNetrwHiddenBuffers
  au!
  au FileType netrw setlocal bufhidden=wipe
augroup end

" Netrw customization
let g:netrw_keepdir= 0
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_alto = 1
let g:netrw_winsize = -30
let g:netrw_sort_sequence = '[\/]$,*'  " sort folders on top

" Netrw toggle - left
function! s:netrwToggle() abort
  Lexplore
  if &ft==#"netrw"
    exe g:netrw_winsize . "wincmd|"
  endif
endfunction
nnoremap <silent> yoe :call <sid>netrwToggle()<cr>
