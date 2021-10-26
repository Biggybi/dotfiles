if ! exists('g:loaded_gitgutter')
  finish
endif

nmap ghm <Plug>(git-messenger-close)<bar><Plug>(git-messenger)
nmap ghs <Plug>(GitGutterPreviewHunk)
nmap gha <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)
