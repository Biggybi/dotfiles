if exists('g:trailspace')
  finish
endif
let g:trailspace = 1

augroup TrailSpace
  au!
  au BufWinEnter * match TrailSpace /\s\+$/
  au InsertEnter * match TrailSpace /\s\+\%#\@<!$/
  au InsertLeave * match TrailSpace /\s\+$/
  au BufWinLeave * call clearmatches()
augroup end
