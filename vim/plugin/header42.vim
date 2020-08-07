if exists('g:plugin_header42')
  finish
endif
let g:plugin_header42 = 1

"""        42Header

let s:asciiart = [
      \"        :::      ::::::::",
      \"      :+:      :+:    :+:",
      \"    +:+ +:+         +:+  ",
      \"  +#+  +:+       +#+     ",
      \"+#+#+#+#+#+   +#+        ",
      \"     #+#    #+#          ",
      \"    ###   ########lyon.fr"
      \]

let s:start   = '/*'
let s:end     = '*/'
let s:fill    = '*'
let s:length  = 80
let s:margin  = 5

let s:types    = {
      \'\.c$\|\.h$\|\.cc$\|\.hh$\|\.cpp$\|\.hpp$\|\.php':
      \['/*', '*/', '*'],
      \'\.htm$\|\.html$\|\.xml$':
      \['<!--', '-->', '*'],
      \'\.js$':
      \['//', '//', '*'],
      \'\.tex$':
      \['%', '%', '*'],
      \'\.ml$\|\.mli$\|\.mll$\|\.mly$':
      \['(*', '*)', '*'],
      \'\.vim$\|\vimrc$':
      \['"', '"', '*'],
      \'\.el$\|\emacs$':
      \[';', ';', '*'],
      \'\.f90$\|\.f95$\|\.f03$\|\.f$\|\.for$':
      \['!', '!', '/']
      \}

function! s:filetype() abort
  let l:f     = s:filename()
  let s:start = '#'
  let s:end   = '#'
  let s:fill  = '*'
  for type in keys(s:types)
    if l:f =~ type
      let s:start = s:types[type][0]
      let s:end   = s:types[type][1]
      let s:fill  = s:types[type][2]
    endif
  endfor
endfunction

function! s:ascii(n) abort
  return s:asciiart[a:n - 3]
endfunction

function! s:textline(left, right)
  let l:left = strpart(a:left, 0, s:length - s:margin * 3 - strlen(a:right) + 1)
  return s:start .
        \ repeat(' ', s:margin - strlen(s:start)) . l:left .
        \ repeat(' ', s:length - s:margin * 2 - strlen(l:left) - strlen(a:right)) . a:right .
        \ repeat(' ', s:margin - strlen(s:end)) . s:end
endfunction

function! s:line(n) abort
  if a:n == 1 || a:n == 11 " top and bottom line
    return s:start . ' ' . repeat(s:fill, s:length - strlen(s:start) - strlen(s:end) - 2) . ' ' . s:end
  elseif a:n == 2 || a:n == 10 " blank line
    return s:textline('', '')
  elseif index([2,3,5,7,10,11], a:n) > 0
    return s:textline('', s:ascii(a:n))
  elseif a:n == 4 " filename
    return s:textline(s:filename(), s:ascii(a:n))
  elseif a:n == 6 " author
    return s:textline("By: " . s:user() . " <" . s:mail() . ">", s:ascii(a:n))
  elseif a:n == 8 " created
    return s:textline("Created: " . s:date() . " by " . s:user(), s:ascii(a:n))
  elseif a:n == 9 " updated
    return s:textline("Updated: " . s:date() . " by " . s:user(), s:ascii(a:n))
  endif
endfunction

function! s:user() abort
  let l:user = $USER
  if l:user == ""
    let l:user = "trx"
  endif
  return l:user
endfunction

function! s:mail() abort
  let l:mail = $MAIL
  if l:mail == ""
    let l:mail = "tristan.kapous@protonmail.com"
  endif
  return l:mail
endfunction

function! s:filename() abort
  let l:filename = expand("%:t")
  if l:filename == ""
    let l:filename = "< new >"
  endif
  return l:filename
endfunction

function! s:date() abort
  return strftime("%Y/%m/%d %H:%M:%S")
endfunction

function! s:insert() abort
  let l:line = 11
  " empty line after header
  call append(0, "")
  " loop over lines
  while l:line > 0
    call append(0, s:line(l:line))
    let l:line = l:line - 1
  endwhile
endfunction

function! s:update() abort
  call s:filetype()
  if getline(9) =~ s:start . repeat(' ', s:margin - strlen(s:start)) . "Updated: "
    if &mod
      call setline(9, s:line(9))
    endif
    call setline(4, s:line(4))
    return 1
  endif
  return 0
endfunction

function! s:header42() abort
  if ! s:update()
    call s:insert()
  endif
endfunction

command! Header42 call s:header42()
nnoremap <silent> <leader>h1 :Header42<cr>
" au BufWritePre * call s:update ()
