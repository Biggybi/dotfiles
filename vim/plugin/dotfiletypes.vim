if exists('g:plugin_dotfiletypes')
  finish
endif
let g:plugin_dotfiletypes = 1

augroup DotfilesSettings
  au!
  au BufEnter,BufWritePost,SourcePost {,.}{bash_aliases,bashrc,inputrc,bash_profile}
        \ setlocal filetype=sh
  au BufWinEnter,BufEnter,SourcePost git/config
        \ setlocal filetype=gitconfig
augroup end

