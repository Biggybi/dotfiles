if exists('g:plugin_autofile')
  finish
endif
let g:plugin_autofile = 1

"""        Save and load

" Save when focus lost, load when focus gained
augroup AutoSaveAndLoadWithFocus
  au!
  au FocusGained,BufEnter,CursorMoved * silent! checktime
  au FocusLost,BufLeave,WinLeave * silent! update
augroup end

" Autocommit
" autocmd BufWritePost * let message = input('Message? ', 'Auto-commit: saved ' . expand('%')) | execute ':silent ! if git rev-parse --git-dir > /dev/null 2>&1 ; then git add % ; git commit -m ' . shellescape(message, 1) . '; fi > /dev/null 2>&1'

"""        Files views

" save folding state (and more based on 'viewoptions')
augroup ReViews
  au!
  au BufWinLeave,BufWrite *
        \ silent! mkview
  au BufWinEnter *
        \ silent! loadview
augroup end

function! FitBufferWindowBottom() abort
  if line('w$') == line('$') && &buftype!='terminal'
    normal! mzGzb`z
  endif
endfunction

augroup FitBufferWindowBottom
  au!
  au WinEnter,WinLeave * call FitBufferWindowBottom()
augroup end

"""        Working directory

" change dir to git repo OR file directory
augroup CdGitRootOrFileDir
  au!
  au BufEnter,BufRead *
        \ if !empty(bufname("%")) && &buftype != 'help'
        \ | silent! cd %:p:h
        \ | if get(g:, 'loaded_fugitive') | silent! Glcd | endif
        \ |else
        \ | silent! lcd %:p:h
        \ |endif
augroup end

"""        Filetype refresh

"  refresh filetype upon writing if no filetype already set
augroup FileTypeRefresh
  au!
  au BufWrite * if &ft ==# '' | filetype detect | endif
augroup end

"""        Large Files

" large file = 10MB
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFilesFast
  au!
  au BufReadPre *
        \ let f=expand("<afile>")
        \ | if getfsize(f) > g:LargeFile || &filetype == 'help'
        \ |   au! anzu
        \ | endif
augroup end

"""        Auto Load Project Files

function! AutoProjectLoad(is_mapping) abort
  let filelist = ".git/vim/project_files"
  if ! filereadable(filelist)
    echom "[E] Project load" filelist ": file not found"
    return
  endif
  if bufname("%") != "" && a:is_mapping == 0
    return
  endif
  exe "e" filelist
  " add every file as argument, excluding comments
  g/\v^[^#].*[^\s]/ if filereadable(expand(expand('<cWORD>'))) | argadd <cWORD>
        \ | endif
  exe "bw" filelist
  wincmd p
endfunction

augroup AutoProjectLoadOnStart
  au!
  au VimEnter * ++nested silent call AutoProjectLoad('0')
augroup end

nnoremap <leader>ej :e .git/vim/project_files<cr>

