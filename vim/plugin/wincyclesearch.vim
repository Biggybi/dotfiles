if exists('g:wincyclesearch')
  finish
endif
let g:wincyclesearch = 1

function! CycleWindowsSearch(direction) abort
  let forward = a:direction
  if ! v:searchforward
    let forward = forward ? '0' : '1'
  endif
  let searchflags = forward ? 'W' : 'Wb'
  let winmove = forward ? 'w' : 'W'
  let curmove = forward ? '1' : '$'
  let firstwin=winnr()
  if ! search(@/, searchflags)
    execute('wincmd ' . winmove)
    let savepos = getcurpos()
    call cursor(curmove, curmove)
    while ! search(@/, searchflags) && firstwin != winnr()
      call setpos('.', savepos)
      execute('wincmd ' . winmove)
      call cursor(curmove, curmove)
    endwhile
  endif
endfunction
