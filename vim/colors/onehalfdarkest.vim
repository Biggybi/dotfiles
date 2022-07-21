" ==============================================================================
"   Name:        One Half Dark
"   Author:      Son A. Pham <sp@sonpham.me>
"   Url:         https://github.com/sonph/onehalf
"   License:     The MIT License (MIT)
"
"   A dark vim color scheme based on Atom's One. See github.com/sonph/onehalf
"   for installation instructions, a light color scheme, versions for other
"   editors/terminals, and a matching theme for vim-airline.
" ==============================================================================

set background=dark
highlight clear
syntax reset

let g:colors_name="onehalfdarkest"

let s:b = { "gui": "#181a1f", "cterm": "236" } " black
let s:r = { "gui": "#e06c75", "cterm": "168" } " red
let s:g = { "gui": "#98c379", "cterm": "114" } " green
let s:y = { "gui": "#e5c07b", "cterm": "180" } " yellow
let s:B = { "gui": "#61afef", "cterm": "75"  } " blue
let s:p = { "gui": "#c678dd", "cterm": "176" } " purple
let s:c = { "gui": "#56b6c2", "cterm": "73"  } " cyan
let s:w = { "gui": "#dcdfe4", "cterm": "188" } " white

let s:g1 = { "gui": "#313640", "cterm": "237" } " grey 1
let s:g2 = { "gui": "#373C45", "cterm": "239" } " grey 2
let s:g3 = { "gui": "#474e5d", "cterm": "239" } " grey 3
let s:g4 = { "gui": "#5c6370", "cterm": "241" } " grey 4
let s:g5 = { "gui": "#919baa", "cterm": "247" } " grey 5

let s:fg = s:w
let s:bg = s:b

function! s:h(group, fg, bg, attr)
  if type(a:fg) == type({})
    exec "hi " . a:group . " guifg=" . a:fg.gui . " ctermfg=" . a:fg.cterm
  else
    exec "hi " . a:group . " guifg=NONE cterm=NONE"
  endif
  if type(a:bg) == type({})
    exec "hi " . a:group . " guibg=" . a:bg.gui . " ctermbg=" . a:bg.cterm
  else
    exec "hi " . a:group . " guibg=NONE ctermbg=NONE"
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  else
    exec "hi " . a:group . " gui=NONE cterm=NONE"
  endif
endfun

" User interface colors {
call s:h("Normal",       s:fg, s:bg, "")

call s:h("Cursor",       s:fg, s:B, "")
call s:h("CursorColumn", "", s:g1, "")
call s:h("CursorLine",   "", "", "")

call s:h("LineNr",       s:g4, s:bg, "")
call s:h("CursorLineNr", s:fg, s:g3, "")

call s:h("DiffAdd",      s:g, "", "")
call s:h("DiffChange",   s:y, "", "")
call s:h("DiffDelete",   s:r, "", "")
call s:h("DiffText",     s:B, "", "")

call s:h("IncSearch",    s:bg, s:p, "")
call s:h("Search",       s:bg, s:B, "")
call s:h("FirstSearch",  s:bg, s:g, "")
call s:h("LastSearch",   s:bg, s:r, "")

call s:h("ErrorMsg",     s:r, "", "")
call s:h("ModeMsg",      s:fg, "", "")
call s:h("MoreMsg",      s:fg, "", "")
call s:h("WarningMsg",   s:r, "", "")
call s:h("Question",     s:p, "", "")

call s:h("Pmenu",        s:fg, s:g2, "")
call s:h("PmenuSel",     s:fg, s:g3, "")
call s:h("PmenuSbar",    s:fg, s:g3, "")
call s:h("PmenuThumb",   s:fg, s:g2, "")

call s:h("SpellBad",     s:r, "", "")
call s:h("SpellCap",     s:y, "", "")
call s:h("SpellLocal",   s:y, "", "")
call s:h("SpellRare",    s:y, "", "")

call s:h("Visual",       "", s:g3, "")
call s:h("VisualNOS",    "", s:g3, "")

call s:h("ColorColumn",  "", s:g1, "")
call s:h("Conceal",      s:fg, "", "")
call s:h("Directory",    s:B, "", "")
call s:h("VertSplit",    s:g2, "", "")
call s:h("Folded",       s:g4, "", "")
call s:h("FoldColumn",   s:fg, "", "")
call s:h("SignColumn",   s:fg, "", "")
call s:h("QuickFixLine", "", s:g1, "")

call s:h("MatchParen",   s:B, s:g3, "")
call s:h("SpecialKey",   s:fg, "", "")
call s:h("Title",        s:g, "", "")
call s:h("WildMenu",     s:fg, "", "")

call s:h("StatusLine",       s:B, s:g2, "")
call s:h("StatusLineNC",     s:g4, s:g2, "")
call s:h("StatusLineTerm",   s:B, s:g2, "")
call s:h("StatusLineTermNC", s:g4, s:g2, "")
call s:h("TabLine",          s:fg, s:g2, "")
call s:h("TabLineFill",      s:g4, s:bg, "")
call s:h("TabLineSel",       s:fg, s:g4, "")
" }

" Syntax colors {
" Whitespace is defined in Neovim, not Vim.
" See :help hl-Whitespace and :help hl-SpecialKey
call s:h("Whitespace",   s:g2, "", "")
call s:h("NonText",      s:bg, s:bg, "")
call s:h("Comment",      s:g4, "", "italic")
call s:h("Constant",     s:c, "", "")
call s:h("String",       s:g, "", "")
call s:h("Character",    s:g, "", "")
call s:h("Number",       s:y, "", "")
call s:h("Boolean",      s:y, "", "")
call s:h("Float",        s:y, "", "")

call s:h("Identifier",   s:r, "", "")
call s:h("Function",     s:B, "", "")
call s:h("Statement",    s:p, "", "")

call s:h("Conditional",  s:p, "", "")
call s:h("Repeat",       s:p, "", "")
call s:h("Label",        s:p, "", "")
call s:h("Operator",     s:fg, "", "")
call s:h("Keyword",      s:r, "", "")
call s:h("Exception",    s:p, "", "")

call s:h("PreProc",      s:y, "", "")
call s:h("Include",      s:p, "", "")
call s:h("Define",       s:p, "", "")
call s:h("Macro",        s:p, "", "")
call s:h("PreCondit",    s:y, "", "")

call s:h("Type",         s:y, "", "")
call s:h("StorageClass", s:y, "", "")
call s:h("Structure",    s:y, "", "")
call s:h("Typedef",      s:y, "", "")

call s:h("Special",        s:B, "", "")
call s:h("SpecialChar",    s:fg, "", "")
call s:h("Tag",            s:y, "", "")
call s:h("Delimiter",      s:r, "", "")
call s:h("SpecialComment", s:fg, "", "")
call s:h("Debug",          s:fg, "", "")
call s:h("Underlined",     s:fg, "", "")
call s:h("Ignore",         s:g4, "", "")
call s:h("Error",          s:r, s:bg, "")
call s:h("Todo",           s:p, "", "")
" }

" Languages {
" Vim
hi link VimUserFunc Function
hi link VimFunction Function

" zsh
hi link zshVariable PreProc
hi link zshFunction Function
" }

" Plugins {
" GitGutter
call s:h("GitGutterAdd",          s:g, s:bg, "")
call s:h("GitGutterDelete",       s:r, s:bg, "")
call s:h("GitGutterChange",       s:y, s:bg, "")
call s:h("GitGutterChangeDelete", s:r, s:bg, "")

" Fugitive
call s:h("diffAdded",   s:g, "", "")
call s:h("diffRemoved", s:r, "", "")
" }

" Suli {
call s:h("SuliNormal",   s:bg, s:g5, "")
call s:h("SuliCmd",      s:bg, s:r, "")
call s:h("SuliVisual",   s:bg, s:p, "")
call s:h("SuliInsert",   s:bg, s:g, "")
call s:h("SuliReplace",  s:bg, s:g, "")
call s:h("SuliFtsearch", s:bg, s:c, "")
call s:h("SuliPending",  s:bg, s:y, "")

" current window
call s:h("SuliFolder",   s:fg, s:g2, "")
call s:h("SuliGitsub",   s:B, s:g2, "")
call s:h("SuliGithead",  s:fg, s:g3, "")
call s:h("SuliGitmod",   s:y, s:g3, "")
call s:h("SuliFilemod",  s:y, s:g1, "")
call s:h("SuliGitdir",   s:g, s:g2, "")
call s:h("SuliGit",      s:g, s:g2, "")
call s:h("SuliMidLeft",  s:B, s:g2, "")
call s:h("SuliMidRight", s:g5, s:g2, "")
call s:h("SuliFileType", s:g5, s:g3, "")
call s:h("SuliMid",      s:fg, s:g1, "")
call s:h("SuliSep",      s:g4, s:g2, "")
call s:h("SuliQf",       s:r, s:g3, "")
call s:h("SuliSpecial",  s:r, s:g3, "")

" non-current window
call s:h("SuliFolderNC",  s:fg, s:g2, "")
call s:h("SuliGitsubNC",  s:B, s:g2, "")
call s:h("SuliGitdirNC",  s:g, s:g2, "")
call s:h("SuliMidNC",     s:g5, s:g1, "")
call s:h("SuliFilemodNC", s:y, s:g1, "")
call s:h("SuliGitHeadNC", s:p, s:g2, "")
call s:h("SuliGitmodNC",  s:y, s:g2, "")
call s:h("SuliQfNC",      s:r, s:g2, "")
call s:h("SuliSpecialNC", s:r, s:g2, "")

call s:h("SuliL1",        s:bg, s:g5, "")
call s:h("SuliL2",        s:w, s:g3, "")
call s:h("SuliL3",        s:w, s:g2, "")
call s:h("SuliR1",        s:g4, s:g5, "")
call s:h("SuliR2",        s:w, s:g3, "")
call s:h("SuliR3",        s:g4, s:g2, "")
call s:h("Suli00",        s:g4, s:g1, "")

call s:h("SuliL2Mod",     s:y, s:g3, "")
call s:h("SuliL3Mod",     s:y, s:g2, "")
call s:h("SuliL2Git",     s:g, s:g3, "")
call s:h("SuliL3Git",     s:g, s:g2, "")
call s:h("SuliL2Ro",      s:p, s:g3, "")
call s:h("SuliL3Ro",      s:p, s:g2, "")

" }

" Git {
call s:h("gitcommitSummary",       s:g, "", "")
call s:h("gitcommitOverflow",      s:r, "", "")
call s:h("gitcommitBlank",         s:B, "", "")
call s:h("gitcommitComment",       s:g4, "", "")
call s:h("gitcommitUnmerged",      s:r, "", "")
call s:h("gitcommitBranch",        s:y, "", "")
call s:h("gitcommitDiscardedType", s:B, "", "")
call s:h("gitcommitSelectedType",  s:B, "", "")
call s:h("gitcommitHeader",        s:p, "", "")
call s:h("gitcommitSelected",      s:g, "", "")
call s:h("gitcommitUntrackedFile", s:y, "", "")
call s:h("gitcommitDiscardedFile", s:r, "", "")
call s:h("gitcommitSelectedFile",  s:g, "", "")
call s:h("gitcommitUnmergedFile",  s:y, "", "")
call s:h("gitcommitFile",          s:fg, "", "")
hi link gitcommitNoBranch gitcommitBranch
hi link gitcommitUntracked gitcommitComment
hi link gitcommitDiscarded gitcommitComment
hi link gitcommitSelected gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow gitcommitSelectedFile
hi link gitcommitUnmergedArrow gitcommitUnmergedFile
" }

hi link User1 SuliNormal
hi link User2 SuliOuter
hi link User3 SuliMid
hi link User4 SuliGitMod
hi link User5 SuliFileMod
hi link User6 SuliCurDir
hi link User7 SuliGit
hi link User8 SuliGitSub
hi link User9 SuliSep

" Fix colors in neovim terminal buffers {
  if has('nvim')
    let g:terminal_color_0  = s:b.gui
    let g:terminal_color_1  = s:r.gui
    let g:terminal_color_2  = s:g.gui
    let g:terminal_color_3  = s:y.gui
    let g:terminal_color_4  = s:B.gui
    let g:terminal_color_5  = s:p.gui
    let g:terminal_color_6  = s:c.gui
    let g:terminal_color_7  = s:w.gui
    let g:terminal_color_8  = s:b.gui
    let g:terminal_color_9  = s:r.gui
    let g:terminal_color_10 = s:g.gui
    let g:terminal_color_11 = s:y.gui
    let g:terminal_color_12 = s:B.gui
    let g:terminal_color_13 = s:p.gui
    let g:terminal_color_14 = s:c.gui
    let g:terminal_color_15 = s:w.gui
    let g:terminal_color_background = s:bg.gui
    let g:terminal_color_foreground = s:fg.gui
  endif
" }

if has("terminal") || has("nvim")
  let g:terminal_ansi_colors = [
        \ s:b.gui,
        \ s:r.gui,
        \ s:g.gui,
        \ s:y.gui,
        \ s:B.gui,
        \ s:p.gui,
        \ s:c.gui,
        \ s:w.gui,
        \ s:g3.gui,
        \ s:r.gui,
        \ s:g.gui,
        \ s:y.gui,
        \ s:B.gui,
        \ s:p.gui,
        \ s:c.gui,
        \ s:w.gui
        \]
endif

