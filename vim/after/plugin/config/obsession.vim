if ! exists(':Obsession')
  finish
endif

function! ToggleObsession()
  if ObsessionStatus() == ""
    :Obsession .git/Session.vim
  else
    :Obsession
  endif
endfunction

nnoremap yoo :call ToggleObsession()<cr>
