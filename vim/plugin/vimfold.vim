if exists('g:plugin_vimfold')
  finish
endif
let g:plugin_trailspace = 1

function! VimFold() abort
  let line = getline(v:foldstart)
  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 4
  if windowwidth > 79
    let windowwidth = 79
  endif
  let foldedlinecount = v:foldend - v:foldstart
  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')
  let longbreak=" "
  let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount))
  if len(line) > windowwidth - 15
    let line=line[0:windowwidth - 15]
    let longbreak="¬"
  endif
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . longbreak . repeat(" ", fillcharcount%2 + len(foldedlinecount) - 1) . '' .
        \ repeat(" .",fillcharcount/2 - 3) .
        \ repeat(" ", 5 - len(foldedlinecount)) . foldedlinecount . '    '
endfunction
