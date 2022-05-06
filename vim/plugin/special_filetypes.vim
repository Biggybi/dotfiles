if exists('g:plugin_dotfiletypes')
  finish
endif
let g:plugin_dotfiletypes = 1

augroup SpecialFiletypes
  au!
  au BufNewFile,BufRead,BufEnter,SourcePost {*/,}git/config
        \ setlocal filetype=gitconfig
  au BufNewFile,BufRead,BufEnter,SourcePost Jenkinsfile
        \ setlocal filetype=groovy
  au BufNewFile,BufRead,BufEnter,SourcePost
        \ *.bash,.bashrc,bashrc,bash.bashrc,.bash[_-]profile,
        \.bash[_-]logout,.bash[_-]aliases,bash-fc[-.],
        \*.ebuild,*.eclass,PKGBUILD,APKBUILD
        \ setlocal filetype=bash
augroup end
