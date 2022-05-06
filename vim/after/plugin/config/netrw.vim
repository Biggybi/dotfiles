if ! exists(':Explore')
  finish
endif

" open netrw if vim starts without file
let g:netrw_startup = 0
let g:netrw_startup_no_file = 0
let g:netrw_home = "vim/tmp/plugin"

augroup NetrwStartup
  au!
  au VimEnter * if g:netrw_startup_no_file == '1' && expand("%") == "" | e . | endif
  au VimEnter * if g:netrw_startup == '1' && expand('%') == "" | Lexplore | wincmd w | endif
augroup end

augroup AutoDeleteNetrwHiddenBuffers
  au!
  au FileType netrw setlocal bufhidden=wipe
augroup end

" Netrw customization
let g:netrw_keepdir= 0
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netrw_alto = 1
let g:netrw_winsize = -30
let g:netrw_sort_sequence = '[\/]$,*'  " sort folders on top
