if exists('g:plugin_historyblacklist')
  finish
endif
let g:plugin_historyblacklist = 1

" Auto remove some commands from history
let g:commands_to_delete_from_history = get(g:, 'commands_to_delete_from_history', ['Delete', 'bw', 'bd'])

function! DeleteCommandsFromHistory()
  let lastHistoryEntry = histget('cmd', -1)
  if trim(lastHistoryEntry) == ""
    return
  endif
  let lastCommand = split(lastHistoryEntry, '\s\+')[0]
  if (index(g:commands_to_delete_from_history, lastCommand) >= 0)
    call histdel('cmd', -1)
  endif
endfunction

augroup history_deletion
  au!
  au CmdlineLeave * call DeleteCommandsFromHistory()
augroup end
