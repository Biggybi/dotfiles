if ! exists('g:loaded_gitgutter')
  finish
endif

nmap ghm <Plug>(git-messenger-close)<bar><Plug>(git-messenger)
nmap ghd <Plug>(GitGutterPreviewHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

function! s:gitGutterIsFloatPreviewOpen() abort
  return !empty(filter(map(tabpagebuflist(), 'bufname(v:val)'), 'v:val=="gitgutter://hunk-preview"'))
endfunction

" jump to hunk and open preview if it was opened already
nmap <expr> [c <sid>gitGutterIsFloatPreviewOpen()
      \? '<Plug>(GitGutterPrevHunk)<Plug>(GitGutterPreviewHunk)'
      \:'<Plug>(GitGutterPrevHunk)'
nmap <expr> ]c <sid>gitGutterIsFloatPreviewOpen()
      \? '<Plug>(GitGutterNextHunk)<Plug>(GitGutterPreviewHunk)'
      \:'<Plug>(GitGutterNextHunk)'
