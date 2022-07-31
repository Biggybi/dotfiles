" ==============================================================================
"   Name:        One Half Light
"   Author:      Son A. Pham <sp@sonpham.me>
"   Url:         https://github.com/sonph/onehalf
"   License:     The MIT License (MIT)
"
"   A light vim color scheme based on Atom's One. See github.com/sonph/onehalf
"   for installation instructions, a dark color scheme, versions for other
"   editors/terminals, and a matching theme for vim-airline.
" ==============================================================================

set background=light
highlight clear
syntax reset

let g:colors_name="onehalflightdim"

let s:bk = { "gui": "#383a42", "cterm": "237" }
let s:rd = { "gui": "#e45649", "cterm": "167" }
let s:gn = { "gui": "#50a14f", "cterm": "71" }
let s:yw = { "gui": "#c18401", "cterm": "136" }
let s:be = { "gui": "#0184bc", "cterm": "31" }
let s:pe = { "gui": "#a626a4", "cterm": "127" }
let s:cn = { "gui": "#0997b3", "cterm": "31" }
let s:we = { "gui": "#E0E0E0", "cterm": "231" }

let s:g5 = { "gui": "#909096", "cterm": "239" }
let s:g4 = { "gui": "#a5a5a5", "cterm": "239" }   "grey2
let s:g3 = { "gui": "#bebebe", "cterm": "239" }   "grey3
let s:g2 = { "gui": "#cecece", "cterm": "241" }   "grey2
let s:g1 = { "gui": "#d8d8d8", "cterm": "247" }   "grey1 (dark)

let s:fg = s:bk
let s:bg = s:we

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

call s:h("Cursor",       s:fg, s:be, "")
call s:h("CursorColumn", "", s:g1, "")
call s:h("CursorLine",   "", "", "")

call s:h("LineNr",       s:g4, s:bg, "")
call s:h("CursorLineNr", s:fg, s:g3, "")

call s:h("DiffAdd",      s:gn, "", "")
call s:h("DiffChange",   s:yw, "", "")
call s:h("DiffDelete",   s:rd, "", "")
call s:h("DiffText",     s:be, "", "")

call s:h("IncSearch",    s:bg, s:pe, "")
call s:h("Search",       s:bg, s:be, "")
call s:h("FirstSearch",  s:bg, s:gn, "")
call s:h("LastSearch",   s:bg, s:rd, "")

call s:h("ErrorMsg",     s:rd, "", "")
call s:h("ModeMsg",      s:fg, "", "")
call s:h("MoreMsg",      s:fg, "", "")
call s:h("WarningMsg",   s:rd, "", "")
call s:h("Question",     s:pe, "", "")

call s:h("Pmenu",        s:fg, s:g2, "")
call s:h("PmenuSel",     s:fg, s:g3, "")
call s:h("PmenuSbar",    s:fg, s:g3, "")
call s:h("PmenuThumb",   s:fg, s:g2, "")

call s:h("SpellBad",     s:rd, "", "")
call s:h("SpellCap",     s:yw, "", "")
call s:h("SpellLocal",   s:yw, "", "")
call s:h("SpellRare",    s:yw, "", "")

call s:h("Visual",       "", s:g3, "")
call s:h("VisualNOS",    "", s:g3, "")

call s:h("ColorColumn",  "", s:g1, "")
call s:h("Conceal",      s:fg, "", "")
call s:h("Directory",    s:be, "", "")
call s:h("VertSplit",    s:g2, "", "")
call s:h("Folded",       s:g4, "", "")
call s:h("FoldColumn",   s:fg, "", "")
call s:h("SignColumn",   s:fg, "", "")
call s:h("QuickFixLine", "", s:g1, "")

call s:h("MatchParen",   s:be, s:g3, "")
call s:h("SpecialKey",   s:fg, "", "")
call s:h("Title",        s:be, "", "")
call s:h("WildMenu",     s:fg, "", "")

call s:h("StatusLine",       s:be, s:g2, "")
call s:h("StatusLineNC",     s:g5, s:g2, "")
call s:h("StatusLineTerm",   s:be, s:g2, "")
call s:h("StatusLineTermNC", s:g5, s:g2, "")
call s:h("TabLine",          s:g5, s:g2, "")
call s:h("TabLineSel",       s:fg, s:g4, "")
call s:h("TabLineFill",      s:g5, s:bg, "")
" }

" Syntax colors {
" Whitespace is defined in Neovim, not Vim.
" See :help hl-Whitespace and :help hl-SpecialKey
call s:h("Whitespace",   s:g2, "", "")
call s:h("NonText",      s:bg, s:bg, "")
call s:h("Comment",      s:g4, "", "italic")
call s:h("Constant",     s:cn, "", "")
call s:h("String",       s:gn, "", "")
call s:h("Character",    s:gn, "", "")
call s:h("Number",       s:yw, "", "")
call s:h("Boolean",      s:yw, "", "")
call s:h("Float",        s:yw, "", "")

call s:h("Identifier",   s:rd, "", "")
call s:h("Function",     s:be, "", "")
call s:h("Statement",    s:pe, "", "")

call s:h("Conditional",  s:pe, "", "")
call s:h("Repeat",       s:pe, "", "")
call s:h("Label",        s:pe, "", "")
call s:h("Operator",     s:yw, "", "")
call s:h("Keyword",      s:rd, "", "")
call s:h("Exception",    s:pe, "", "")

call s:h("PreProc",      s:yw, "", "")
call s:h("Include",      s:pe, "", "")
call s:h("Define",       s:pe, "", "")
call s:h("Macro",        s:pe, "", "")
call s:h("PreCondit",    s:yw, "", "")

call s:h("Type",         s:yw, "", "")
call s:h("StorageClass", s:yw, "", "")
call s:h("Structure",    s:yw, "", "")
call s:h("Typedef",      s:yw, "", "")

call s:h("Special",        s:be, "", "")
call s:h("SpecialChar",    s:fg, "", "")
call s:h("Tag",            s:yw, "", "")
call s:h("Delimiter",      s:rd, "", "")
call s:h("SpecialComment", s:fg, "", "")
call s:h("Debug",          s:fg, "", "")
call s:h("Underlined",     s:fg, "", "")
call s:h("Ignore",         s:g4, "", "")
call s:h("Error",          s:rd, s:bg, "")
call s:h("Todo",           s:pe, "", "")
" }

" Languages {
" Vim
" hi link VimParenSep Identifier
hi link VimUserFunc Function
hi link VimFunction Function

" zsh
hi link zshVariable PreProc
hi link zshFunction Function
" }

" Plugins {
" GitGutter
call s:h("GitGutterAdd",          s:gn, s:bg, "")
call s:h("GitGutterDelete",       s:rd, s:bg, "")
call s:h("GitGutterChange",       s:yw, s:bg, "")
call s:h("GitGutterChangeDelete", s:rd, s:bg, "")

" Fugitive
call s:h("diffAdded",   s:gn, "", "")
call s:h("diffRemoved", s:rd, "", "")
" }

" Plugins {
" GitGutter
call s:h("GitGutterAdd",          s:gn, s:bg, "")
call s:h("GitGutterDelete",       s:rd, s:bg, "")
call s:h("GitGutterChange",       s:yw, s:bg, "")
call s:h("GitGutterChangeDelete", s:rd, s:bg, "")

" Fugitive
call s:h("diffAdded",   s:gn, "", "")
call s:h("diffRemoved", s:rd, "", "")
" }

" Suli {
call s:h("SuliNormal",   s:bg, s:g5, "")
call s:h("SuliCmd",      s:bg, s:rd, "")
call s:h("SuliVisual",   s:bg, s:pe, "")
call s:h("SuliInsert",   s:bg, s:gn, "")
call s:h("SuliReplace",  s:bg, s:gn, "")
call s:h("SuliFtsearch", s:bg, s:cn, "")
call s:h("SuliPending",  s:bg, s:yw, "")

" current window
call s:h("SuliFolder",   s:fg, s:g2, "")
call s:h("SuliGitsub",   s:be, s:g2, "")
call s:h("SuliGithead",  s:fg, s:g3, "")
call s:h("SuliGitmod",   s:yw, s:g3, "")
call s:h("SuliFilemod",  s:yw, s:g1, "")
call s:h("SuliGitdir",   s:gn, s:g2, "")
call s:h("SuliGit",      s:gn, s:g2, "")
call s:h("SuliMidLeft",  s:be, s:g2, "")
call s:h("SuliMidRight", s:g5, s:g2, "")
call s:h("SuliFileType", s:fg, s:g3, "")
call s:h("SuliMid",      s:fg, s:g1, "")
call s:h("SuliSep",      s:g4, s:g2, "")
call s:h("SuliQf",       s:be, s:g3, "")
call s:h("SuliSpecial",  s:rd, s:g3, "")

" non-current window
call s:h("SuliFolderNC",  s:fg, s:g2, "")
call s:h("SuliGitsubNC",  s:be, s:g2, "")
call s:h("SuliGitdirNC",  s:gn, s:g2, "")
call s:h("SuliMidNC",     s:g5, s:g1, "")
call s:h("SuliFilemodNC", s:yw, s:g1, "")
call s:h("SuliGitHeadNC", s:pe, s:g2, "")
call s:h("SuliGitmodNC",  s:yw, s:g2, "")
call s:h("SuliQfNC",      s:rd, s:g2, "")
call s:h("SuliSpecialNC", s:rd, s:g2, "")

call s:h("SuliL1",        s:bg, s:g5, "")
call s:h("SuliR1",        s:g4, s:g5, "")
call s:h("SuliR2",        s:fg, s:g3, "")
call s:h("SuliR3",        s:g4, s:g2, "")
call s:h("Suli00",        s:g4, s:g1, "")

call s:h("SuliL2",        s:fg, s:g4, "")
call s:h("SuliL2Mod",     s:yw, s:g4, "")
call s:h("SuliL2Ro",      s:pe, s:g4, "")
call s:h("SuliL2Git",     s:gn, s:g4, "")
call s:h("SuliL2Sub",     s:be, s:g4, "")

call s:h("SuliL3",        s:fg, s:g3, "")
call s:h("SuliL3Mod",     s:yw, s:g3, "")
call s:h("SuliL3Ro",      s:pe, s:g3, "")
call s:h("SuliL3Git",     s:gn, s:g3, "")
call s:h("SuliL3GitMod",  s:rd, s:g3, "")
call s:h("SuliL3Sub",     s:be, s:g3, "")
call s:h("SuliL3SubMod",  s:rd, s:g3, "")

call s:h("SuliL4",        s:fg, s:g2, "")
call s:h("SuliL4Mod",     s:yw, s:g2, "")
call s:h("SuliL4Ro",      s:pe, s:g2, "")
call s:h("SuliL4Git",     s:gn, s:g2, "")
call s:h("SuliL4Sub",     s:be, s:g3, "")

call s:h("SuliNC",        s:g5, s:g2, "")
call s:h("SuliNCMod",     s:yw, s:g2, "")
call s:h("SuliNCRo",      s:pe, s:g2, "")
call s:h("SuliNCGit",     s:gn, s:g2, "")
call s:h("SuliNCGitMod",  s:rd, s:g2, "")
call s:h("SuliNCSub",     s:be, s:g2, "")
call s:h("SuliNCSubMod",  s:rd, s:g2, "")

" }

" HTML
call s:h("htmlBold",    s:pe, "", "")
call s:h("htmlItalic",  s:yw, "", "")
call s:h("htmlEndTag",  s:pe, "", "")
call s:h("htmlTag",     s:pe, "", "")
call s:h("htmlLink",    s:rd, "", "")

" Markdown {
call s:h("markdownCode",              s:gn, "", "")
call s:h("markdownError",             s:fg, s:bg, "")
call s:h("markdownCodeBlock",         s:gn, "", "")
call s:h("markdownHeadingDelimiter",  s:be, "", "")
" }

" Git {
call s:h("gitcommitSummary",       s:gn, "", "")
call s:h("gitcommitOverflow",      s:rd, "", "")
call s:h("gitcommitBlank",         s:be, "", "")
call s:h("gitcommitComment",       s:g4, "", "")
call s:h("gitcommitUnmerged",      s:rd, "", "")
call s:h("gitcommitBranch",        s:yw, "", "")
call s:h("gitcommitDiscardedType", s:be, "", "")
call s:h("gitcommitSelectedType",  s:be, "", "")
call s:h("gitcommitHeader",        s:pe, "", "")
call s:h("gitcommitSelected",      s:gn, "", "")
call s:h("gitcommitUntrackedFile", s:yw, "", "")
call s:h("gitcommitDiscardedFile", s:rd, "", "")
call s:h("gitcommitSelectedFile",  s:gn, "", "")
call s:h("gitcommitUnmergedFile",  s:yw, "", "")
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

" neovim terminal {
  if has('nvim')
    let g:terminal_color_0  = s:fg.gui
    let g:terminal_color_1  = s:rd.gui
    let g:terminal_color_2  = s:gn.gui
    let g:terminal_color_3  = s:yw.gui
    let g:terminal_color_4  = s:be.gui
    let g:terminal_color_5  = s:pe.gui
    let g:terminal_color_6  = s:cn.gui
    let g:terminal_color_7  = s:bg.gui
    let g:terminal_color_8  = s:fg.gui
    let g:terminal_color_9  = s:rd.gui
    let g:terminal_color_10 = s:gn.gui
    let g:terminal_color_11 = s:yw.gui
    let g:terminal_color_12 = s:be.gui
    let g:terminal_color_13 = s:pe.gui
    let g:terminal_color_14 = s:cn.gui
    let g:terminal_color_15 = s:bg.gui
    let g:terminal_color_background = s:bg.gui
    let g:terminal_color_foreground = s:fg.gui
  endif
" }

if has("terminal") || has("nvim")
  let g:terminal_ansi_colors = [
        \ s:fg.gui,
        \ s:rd.gui,
        \ s:gn.gui,
        \ s:yw.gui,
        \ s:be.gui,
        \ s:pe.gui,
        \ s:cn.gui,
        \ s:bg.gui,
        \ s:g4.gui,
        \ s:rd.gui,
        \ s:gn.gui,
        \ s:yw.gui,
        \ s:be.gui,
        \ s:pe.gui,
        \ s:cn.gui,
        \ s:bg.gui
        \]
endif

