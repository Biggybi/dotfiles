"from Habamax https://gist.github.com/habamax/0a6c1d2013ea68adcf2a52024468752e

if exists('g:plugin_better_gx')
  finish
endif
let g:plugin_better_gx = 1

" Better gx to open URLs.
func! s:betterGx() abort
  if exists("$WSLENV")
    lcd /mnt/c
    let cmd = ":silent !cmd.exe /C start"
  elseif has("win32") || has("win32unix")
    let cmd = ':silent !start'
  elseif executable('xdg-open')
    let cmd = ":silent !xdg-open"
  elseif executable('open')
    let cmd = ":silent !open"
  else
    echohl Error
    echomsg "Can't find proper opener for an URL!"
    echohl None
    return
  endif

  " URL regexes
  let rx_base = '\%(\%(http\|ftp\|irc\)s\?\|file\)://\S'
  let rx_bare = rx_base . '\+'
  let rx_embd = rx_base . '\{-}'

  let URL = ""

  " markdown URL [link text](http://ya.ru 'yandex search')
  try
    let save_cursor = getcurpos()
    if searchpair('\[.\{-}\](', '', ')\zs', 'cbW', '', line('.')) > 0
      let URL = matchstr(getline('.')[col('.')-1:], '\[.\{-}\](\zs'.rx_embd.'\ze\(\s\+.\{-}\)\?)')
    endif
  finally
    call setpos('.', save_cursor)
  endtry

  " asciidoc URL http://yandex.ru[yandex search]
  if empty(URL)
    try
      let save_cursor = getcurpos()
      if searchpair(rx_bare . '\[', '', '\]\zs', 'cbW', '', line('.')) > 0
        let URL = matchstr(getline('.')[col('.')-1:], '\S\{-}\ze[')
      endif
    finally
      call setpos('.', save_cursor)
    endtry
  endif

  " HTML URL <a href='http://www.python.org'>Python is here</a>
  "          <a href="http://www.python.org"/>
  if empty(URL)
    try
      let save_cursor = getcurpos()
      if searchpair('<a\s\+href=', '', '\%(</a>\|/>\)\zs', 'cbW', '', line('.')) > 0
        let URL = matchstr(getline('.')[col('.')-1:], 'href=["'."'".']\?\zs\S\{-}\ze["'."'".']\?/\?>')
      endif
    finally
      call setpos('.', save_cursor)
    endtry
  endif

  " barebone URL http://google.com
  if empty(URL)
    let URL = matchstr(expand("<cfile>"), rx_bare)
  endif

  if empty(URL)
    return
  endif

  exe cmd . ' "' . escape(URL, '#%!')  . '"'

  if exists("$WSLENV") | lcd - | endif
endfunc

command! BetterGx :call s:betterGx()
nnoremap <expr> <plug>BetterGx <sid>betterGx()
if !hasmapto('<plug>BetterGx') && maparg('gx', 'n') ==# ''
  nmap gx <plug>BetterGx
endif
