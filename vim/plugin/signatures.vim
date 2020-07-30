if exists('g:plugin_signatures')
  finish
endif
let g:plugin_signatures = 1

function! SignatureMail() abort
  let firstname = "Tristan"
  let surname = "Kapous"
  let email = "<tris@tristankapous.com>"
  let prefix = "--"
  let signature_undated = prefix . " " . firstname . " " . surname . " " . email
  if getline('$') =~ '^.*'.signature_undated
    :$d
  endif
  let signature = signature_undated . " " . strftime('%a, %d %b %Y %H:%M:%S')
  call append('$', signature)
endfunction

function! SignatureDebianLog() abort
  let firstname = "Tristan"
  let surname = "Kapous"
  let email = "<tris@tristankapous.com>"
  let prefix = "--"
  let signature_undated = prefix . " " . firstname . " " . surname . " " . email
  let signature = signature_undated . " " . strftime('%a, %d %b %Y %H:%M:%S %z')
  if getline('.') =~ '^.*'.signature_undated
    call setline('.', signature)
  else
    call append('.', signature)
  endif
endfunction
