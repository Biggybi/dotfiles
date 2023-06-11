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

let g:colors_name="onehalf-dark"

" set winhighlight=Normal:MyNormal,NormalNC:MyNormalNC

let s:bk = { "gui": "#282c34", "cterm": "236" } " black
let s:rd = { "gui": "#e06c75", "cterm": "168" } " red
let s:gn = { "gui": "#98c379", "cterm": "114" } " green
let s:be = { "gui": "#61afef", "cterm": "75"  } " blue
let s:tl = { "gui": "#52B5C2", "cterm": "75"  } " teal
let s:yw = { "gui": "#e5c07b", "cterm": "180" } " yellow
let s:pe = { "gui": "#c678dd", "cterm": "176" } " purple
let s:cn = { "gui": "#ef61af", "cterm": "73"  } " magenta
let s:we = { "gui": "#dcdfe4", "cterm": "188" } " white

let s:bk2 = { "gui": "#282c34", "cterm": "236" } " black
let s:rd2 = { "gui": "#d32d3a", "cterm": "168" } " red
let s:gn2 = { "gui": "#70a54a", "cterm": "114" } " green
let s:be2 = { "gui": "#1c8ce8", "cterm": "75"  } " blue
let s:tl2 = { "gui": "#348893", "cterm": "75"  } " teal
let s:yw2 = { "gui": "#d8a13b", "cterm": "180" } " yellow
let s:pe2 = { "gui": "#ac3bce", "cterm": "176" } " purple
let s:cn2 = { "gui": "#e81c8c", "cterm": "73"  } " magenta
let s:we2 = { "gui": "#dcdfe4", "cterm": "188" } " white

"  shades of #474e5d, dark to light
" #14161a
" #252931
" #363b47
" #474e5d
" #586173
" #697389
" #7e879c
" #949cad
" #aab0be
" #c0c5cf
" #d7dae0
" #edeef1

let s:g1 = { "gui": "#14161a", "cterm": "247" }
let s:g1 = { "gui": "#252931", "cterm": "247" }
let s:g1 = { "gui": "#363b47", "cterm": "247" }
let s:g2 = { "gui": "#474e5d", "cterm": "247" }
let s:g3 = { "gui": "#586173", "cterm": "247" }
let s:g4 = { "gui": "#697389", "cterm": "247" }
let s:g5 = { "gui": "#7e879c", "cterm": "247" }
let s:g6 = { "gui": "#949cad", "cterm": "247" }
" let s:g1 = { "gui": "#aab0be", "cterm": "247" }
" let s:g1 = { "gui": "#c0c5cf", "cterm": "247" }
" let s:g1 = { "gui": "#d7dae0", "cterm": "247" }
" let s:g1 = { "gui": "#edeef1", "cterm": "247" }

let s:g1 = { "gui": "#313640", "cterm": "237" } " grey 1
let s:g2 = { "gui": "#373C45", "cterm": "239" } " grey 2
let s:g3 = { "gui": "#474e5d", "cterm": "239" } " grey 3
let s:g4 = { "gui": "#5c6370", "cterm": "241" } " grey 4
let s:g5 = { "gui": "#919baa", "cterm": "247" } " grey 5
let s:g6 = { "gui": "#B2B9C3", "cterm": "247" } " grey 5

let s:fg = s:we
let s:bg = s:bk

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

if has('nvim')
  doau ColorScheme g:colors_name ReColor
endif
augroup ReColor
  au!
  " User interface colors {
  call s:h("Normal",       s:fg, "", "")
  " call s:h("NormalNC",     s:fg, s:g1, "")

  call s:h("Cursor",       s:fg, s:be, "")
  call s:h("CursorColumn", "", s:g1, "")
  call s:h("CursorLine",   "", "", "")

  call s:h("LineNr",       s:g4, "", "")
  call s:h("CursorLineNr", s:fg, s:g3, "")

  call s:h("DiffAdd",      s:gn, "", "")
  call s:h("DiffChange",   s:yw, "", "")
  call s:h("DiffDelete",   s:rd, "", "")
  call s:h("DiffText",     s:be, "", "")
  call s:h("DiffFile",     s:be, "", "")

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

  if has("nvim")
    call s:h("Pmenu",      s:fg, "", "")
    call s:h("PmenuSel",   "", s:g3, "")
    call s:h("PmenuSbar",  s:be, s:be, "")
    call s:h("PmenuThumb", s:fg, s:g3, "")
  endif

  call s:h("SpellBad",     s:rd, "", "")
  call s:h("SpellCap",     s:yw, "", "")
  call s:h("SpellLocal",   s:yw, "", "")
  call s:h("SpellRare",    s:yw, "", "")

  call s:h("Visual",       "", s:g3, "")
  call s:h("VisualNOS",    "", s:g3, "")

  call s:h("ColorColumn",  "", s:g1, "")
  call s:h("Conceal",      s:fg, "", "")
  call s:h("Directory",    s:be, "", "")
  call s:h("VertSplit",    s:g3, "", "")
  call s:h("Folded",       s:g4, "", "")
  call s:h("FoldColumn",   s:fg, "", "")
  call s:h("SignColumn",   s:fg, "", "")
  call s:h("QuickFixLine", "", s:g1, "")

  call s:h("qfLineNr",     s:gn, "", "")
  call s:h("qfSeparator",  s:fg, "", "")

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
  call s:h("TabLineFill",      s:g5, "", "")

  call s:h("HelpCommand",        s:gn, "", "")
  call s:h("HelpBacktick",       s:gn, "", "")
  call s:h("HelpOption",         s:yw, "", "")
  call s:h("HelpHyperTextEntry", s:pe, "", "")
  call s:h("HelpHeader",         s:be, "", "")
  call s:h("HelpSectionDelim",   s:be, "", "")
  " }

  " Syntax colors {
  " Whitespace is defined in Neovim, not Vim.
  " See :help hl-Whitespace and :help hl-SpecialKey
  call s:h("Whitespace",   s:tl, "", "")
  call s:h("NonText",      s:bg, "", "")
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
  " call s:h("Keyword",      s:rd, "", "")
  call s:h("Keyword",      s:pe, "", "")
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
  call s:h("Error",          s:rd, "", "")
  call s:h("Todo",           s:pe, "", "")

  call s:h("SpellBad",       s:rd, "",  "underline")
  call s:h("SpellCap",       s:pe, "",  "underline") 
  call s:h("SpellRare",      s:yw, "",  "underline")
  call s:h("SpellLocal",     s:be, "",  "underline")

  " Vim
  hi link VimUserFunc Function
  hi link VimFunction Function

  " zsh
  hi link zshVariable PreProc
  hi link zshFunction Function
  " }

  " Plugins {
  call s:h("NotifyBackground",  s:fg, s:bg, "")
  call s:h("NotifyDEBUGBody",   s:g6, "", "")
  call s:h("NotifyDEBUGBorder", s:be, "", "")
  call s:h("NotifyDEBUGIcon",   s:be, "", "")
  call s:h("NotifyDEBUGTitle",  s:be, "", "")
  call s:h("NotifyERRORBody",   s:g6, "", "")
  call s:h("NotifyERRORBorder", s:rd, "", "")
  call s:h("NotifyERRORIcon",   s:rd, "", "")
  call s:h("NotifyERRORTitle",  s:rd, "", "")
  call s:h("NotifyINFOBody",    s:g6, "", "")
  call s:h("NotifyINFOBorder",  s:gn, "", "")
  call s:h("NotifyINFOIcon",    s:gn, "", "")
  call s:h("NotifyINFOTitle",   s:gn, "", "")
  call s:h("NotifyTRACEBody",   s:g6, "", "")
  call s:h("NotifyTRACEBorder", s:pe, "", "")
  call s:h("NotifyTRACEIcon",   s:pe, "", "")
  call s:h("NotifyTRACETitle",  s:pe, "", "")
  call s:h("NotifyWARNBody",    s:g6, "", "")
  call s:h("NotifyWARNBorder",  s:yw, "", "")
  call s:h("NotifyWARNIcon",    s:yw, "", "")
  call s:h("NotifyWARNTitle",   s:yw, "", "")

  " GitGutter
  call s:h("GitGutterAdd",          s:gn2, "", "")
  call s:h("GitGutterDelete",       s:rd2, "", "")
  call s:h("GitGutterChange",       s:yw2, "", "")
  call s:h("GitGutterChangeDelete", s:rd2, "", "")

  " Fugitive
  call s:h("diffAdded",   s:gn, "", "")
  call s:h("diffRemoved", s:rd, "", "")
  call s:h("fugitiveUntrackedHeading",  s:gn, "", "")
  call s:h("fugitiveUntrackedModifier", s:gn, "", "")
  call s:h("fugitiveUnstagedHeading",   s:be, "", "")
  call s:h("fugitiveUnstagedModifier",  s:be, "", "")
  call s:h("fugitiveStagedHeading",     s:pe, "", "")
  call s:h("fugitiveStagedModifier",    s:pe, "", "")
  call s:h("fugitiveHeading",           s:rd, "", "")
  call s:h("fugitiveHash",              s:rd, "", "")
  call s:h("fugitiveHeader",            s:rd, "", "")
  call s:h("fugitiveHelpHeader",        s:rd, "", "")

  " " Coc
  " " hi! link CocListLine QuickFixLine
  call s:h("CocListLine",          s:fg, s:g3, "")
  call s:h("CocListSearch",        s:be,   "", "")
  call s:h("CocListMode",          s:bg, s:g5, "")
  call s:h("CocListPath",          s:bg, s:g5, "")
  " call s:h("CocSelectedText",      s:bg, s:g5, "")
  " call s:h("CocSelectedLine",      s:bg, s:g5, "")
  " call s:h("CocSearch",            s:be, s:g2, "")
  " call s:h("CocFloatDividingLine", s:g3, s:g2, "")
  " hi link CocPum                   PmenuSbar
  " hi link CocPumSearch             CocSearch
  " hi link CocFloating              Pmenu
  " hi link CocFloatThumb            PmenuThumb
  " hi link CocFloatSbar             PmenuSbar
  " hi link CocMenuSel               PmenuSel
  " hi link CocFloatActive           PmenuSel
  hi link CocPumVirtualText        ErrorMsg

  " coc preview with box experimentation
  call s:h("CocFloating",          s:fg, "", "")
  call s:h("CocFloatDividingLine", s:g5, "", "")
  call s:h("CocBorder",            s:g6, s:fg, "")
  call s:h("CocFloatThumb",        s:g3, s:g3, "")
  call s:h("CocFloatSbar",         s:bg, "", "")
  call s:h("CocMenuSel",           s:fg, s:g3, "")
  call s:h("CocPumSearch",         s:rd, "", "")

  " call s:h("CocPumMenu",           s:rd, "", "")
  " call s:h("CocFloatActive",       s:rd, s:pe, "")
  " call s:h("CocPumMenu",           s:rd, s:pe, "")

  hi link CocErrorFloat            ErrorMsg
  hi link CocHintFloat             DiagnosticHint

  " checkhealth {
  call s:h("healthSuccess",     s:bg, s:gn2, "")
  call s:h("healthWarning",     s:bg, s:yw2, "")
  call s:h("healthError",       s:bg, s:rd2, "")
  call s:h("healthHeadingChar", s:pe, "", "bold")
  call s:h("healthHelpSectionDelim", s:pe, "", "bold")
  " }

  " Indent Blank Lines
  call s:h("IndentBlanklineIndent0",     s:g1, "", "")
  call s:h("IndentBlanklineIndent1",     s:g1, "", "")
  call s:h("IndentBlanklineIndent2",     s:g1, "", "")
  call s:h("IndentBlanklineIndent3",     s:g1, "", "")
  call s:h("IndentBlanklineIndent4",     s:g1, "", "")
  call s:h("IndentBlanklineIndent5",     s:g1, "", "")
  call s:h("IndentBlanklineIndent6",     s:g1, "", "")
  call s:h("IndentBlanklineContextChar", s:g4, "", "")
  " }

  " Suli {
  call s:h("SuliNormal",   s:bg, s:g5, "")
  call s:h("SuliCmd",      s:bg, s:rd, "")
  call s:h("SuliVisual",   s:bg, s:pe, "")
  call s:h("SuliInsert",   s:bg, s:gn, "")
  call s:h("SuliReplace",  s:bg, s:gn, "")
  call s:h("SuliFtsearch", s:bg, s:cn, "")
  call s:h("SuliPending",  s:bg, s:yw, "")

  call s:h("SuliTerm",     s:bg, s:rd, "")

  " current window
  call s:h("SuliFolder",   s:fg, s:g2, "")
  call s:h("SuliGitsub",   s:be, s:g3, "")
  call s:h("SuliGithead",  s:fg, s:g3, "")
  call s:h("SuliGitmod",   s:yw, s:g3, "")
  call s:h("SuliFilemod",  s:yw, s:g1, "")
  call s:h("SuliGitdir",   s:gn, s:g2, "")
  call s:h("SuliGit",      s:gn, s:g2, "")
  call s:h("SuliMidLeft",  s:be, s:g2, "")
  call s:h("SuliMidRight", s:g5, s:g2, "")
  call s:h("SuliFileType", s:g5, s:g3, "")
  call s:h("SuliMid",      s:fg, s:g2, "")
  call s:h("SuliSep",      s:g4, s:g2, "")
  call s:h("SuliQf",       s:be, s:g3, "")
  call s:h("SuliQfTitle",  s:yw, s:g3, "")
  call s:h("SuliSpecial",  s:rd, s:g3, "")

  " non-current window
  call s:h("SuliFolderNC",  s:fg, s:g3, "")
  call s:h("SuliGitsubNC",  s:be, s:g3, "")
  call s:h("SuliGitdirNC",  s:gn, s:g3, "")
  call s:h("SuliMidNC",     s:g5, s:g3, "")
  call s:h("SuliFilemodNC", s:yw, s:g3, "")
  call s:h("SuliGitHeadNC", s:pe, s:g3, "")
  call s:h("SuliGitmodNC",  s:yw, s:g3, "")
  call s:h("SuliQfNC",      s:be, s:g3, "")
  call s:h("SuliSpecialNC", s:rd, s:g3, "")
  call s:h("SuliQfTitleNC", s:yw, s:g3, "")

  call s:h("SuliL1",        s:bg, s:g5, "")
  " not as much colors needed because no `state()`
  if has('nvim')
    call s:h("SuliL1",        s:bg, s:be, "")
  endif
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

  call s:h("SuliDiagErr",   s:rd, s:g3, "")
  call s:h("SuliDiagWarn",  s:yw, s:g3, "")
  call s:h("SuliDiagInfo",  s:gn, s:g3, "")
  call s:h("SuliDiagHint",  s:be, s:g3, "")

  " }

  " HTML
  call s:h("htmlBold",      s:pe, "", "")
  call s:h("htmlItalic",    s:yw, "", "")
  call s:h("htmlEndTag",    s:pe, "", "")
  call s:h("htmlTagN",      s:yw, "", "")
  call s:h("htmlTagEndTag", s:yw, "", "")
  call s:h("htmlTagName",   s:yw, "", "")
  call s:h("htmlTag",       s:yw, "", "")
  call s:h("htmlArg",       s:pe, "", "")
  call s:h("htmlLink",      s:rd, "", "")

  " Markdown {
  call s:h("markdownCode",              s:gn, "", "")
  call s:h("markdownDelimiter",         s:gn, "", "")
  call s:h("markdownError",             s:fg, "", "")
  call s:h("markdownCodeBlock",         s:gn, "", "")
  call s:h("markdownHeadingDelimiter",  s:be, "", "")
  call s:h("markdownHeadingDelimiter",  s:be, "", "")
  call s:h("markdownHeadingDelimiter",  s:be, "", "")
  " }

  " Typescript {
  call s:h("typescriptAccessibilityModifier", s:yw, "", "")
  " }

  " VimWiki {
  call s:h("VimWikiItalic",       s:yw, "", "")
  call s:h("VimWikiItalicChar",   s:yw, "", "")
  call s:h("VimWikiBold",         s:pe, "", "")
  call s:h("VimWikiBoldChar",     s:pe, "", "")
  call s:h("VimWikiWeblink1",     s:rd, "", "")
  call s:h("VimWikiWeblink1Char", s:yw, "", "")
  call s:h("VimWikiHeaderChar",   s:rd, "", "")
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
  hi link gitcommitNoBranch       gitcommitBranch
  hi link gitcommitUntracked      gitcommitComment
  hi link gitcommitDiscarded      gitcommitComment
  hi link gitcommitSelected       gitcommitComment
  hi link gitcommitDiscardedArrow gitcommitDiscardedFile
  hi link gitcommitSelectedArrow  gitcommitSelectedFile
  hi link gitcommitUnmergedArrow  gitcommitUnmergedFile
  " }

  " { FLog
  call s:h("flogGraphBranch0", s:gn, "", "")
  call s:h("flogGraphBranch1", s:gn, "", "")
  call s:h("flogGraphBranch2", s:yw, "", "")
  call s:h("flogGraphBranch3", s:be, "", "")
  call s:h("flogGraphBranch4", s:tl, "", "")
  call s:h("flogGraphBranch5", s:pe, "", "")
  call s:h("flogGraphBranch6", s:gn2, "", "")
  call s:h("flogGraphBranch7", s:yw2, "", "")
  call s:h("flogGraphBranch8", s:be2, "", "")
  call s:h("flogGraphBranch9", s:gn2, "", "")
  call s:h("flogDate",         s:pe, "", "")
  call s:h("flogHash",         s:rd, "", "")
  call s:h("flogAuthor",       s:gn, "", "")
  " }

  " lspconfig borders {
  call s:h("NormalFloat", s:fg, "", "")
  call s:h("FloatBorder", s:fg, "", "")
  " }

  " lspconfig diagnostics {
  call s:h("DiagnosticHint",        s:be2, "", "")
  call s:h("DiagnosticInfo",        s:gn2, "", "")
  call s:h("DiagnosticWarning",     s:yw2, "", "")
  call s:h("DiagnosticError",       s:rd2, "", "")
  call s:h("DiagnosticLineNrHint",  s:be2, "", "")
  call s:h("DiagnosticLineNrInfo",  s:gn2, "", "")
  call s:h("DiagnosticLineNrWarn",  s:yw2, "", "")
  call s:h("DiagnosticLineNrError", s:rd2, "", "")
  "}

  " lspconfig complete icons {
  call s:h("CmpItemKindDefault",    s:we, "", "")
  call s:h("CmpItemKindFile",       s:be, "", "")
  call s:h("CmpItemKindFolder",     s:be2, "", "")
  call s:h("CmpItemAbbrDeprecated", s:g4, "", "")
  call s:h("CmpItemAbbrMatch",      s:be, "", "")
  call s:h("CmpItemAbbrMatchFuzzy", s:be, "", "")
  call s:h("CmpItemKindVariable",   s:rd, "", "")
  call s:h("CmpItemKindConstant",   s:rd, "", "")
  call s:h("CmpItemKindClass",      s:pe, "", "")
  call s:h("CmpItemKindModule",     s:cn, "", "")
  call s:h("CmpItemKindInterface",  s:cn, "", "")
  call s:h("CmpItemKindEnum",       s:gn, "", "")
  call s:h("CmpItemKindText",       s:gn, "", "")
  call s:h("CmpItemKindFunction",   s:be, "", "")
  call s:h("CmpItemKindMethod",     s:be, "", "")
  call s:h("CmpItemKindKeyword",    s:pe, "", "")
  call s:h("CmpItemKindField",      s:pe, "", "")
  call s:h("CmpItemKindProperty",   s:pe, "", "")
  call s:h("CmpItemKindUnit",       s:yw, "", "")
  call s:h("CmpItemKindSnippet",    s:yw, "", "")
  call s:h("CmpItemKindOperator",   s:yw, "", "")
  " }

  " lspconfig symbol under cursor {
  call s:h("LspReferenceRead",  "", s:g1, "")
  call s:h("LspReferenceText",  "", s:g1, "")
  call s:h("LspReferenceWrite", "", s:g1, "")
  " }

  " " barbecue (winbar context) {
  " call s:h("BarbecueNormal",           s:g6, "", "")
  " call s:h("BarbecueEllipsis",         s:g6, "", "")
  " call s:h("BarbecueSeparator",        s:g4, "", "")
  " call s:h("BarbecueModified",         s:g6, "", "")
  " call s:h("BarbecueDirname",          s:be, "", "")
  " call s:h("BarbecueBasename",         s:g6, "", "")
  " call s:h("BarbecueContext",          s:g5, "", "")
  " call s:h("BarbecueContextFile",      s:g6, "", "")
  " call s:h("BarbecueContextModule",    s:g6, "", "")
  " call s:h("BarbecueContextNamespace", s:g6, "", "")
  " call s:h("BarbecueContextPackage",   s:g6, "", "")
  " call s:h("BarbecueContextClass",     s:g6, "", "")
  " call s:h("BarbecueMethod",           s:be, "", "")
  " call s:h("BarbecueProperty",         s:g6, "", "")
  " call s:h("BarbecueField",            s:g6, "", "")
  " call s:h("BarbecueConstructor",      s:g6, "", "")
  " call s:h("BarbecueEnum",             s:g6, "", "")
  " call s:h("BarbecueInterface",        s:g6, "", "")
  " call s:h("BarbecueFunction",         s:be, "", "")
  " call s:h("BarbecueVariable",         s:g6, "", "")
  " call s:h("BarbecueConstant",         s:g6, "", "")
  " call s:h("BarbecueString",           s:g6, "", "")
  " call s:h("BarbecueNumber",           s:g6, "", "")
  " call s:h("BarbecueBoolean",          s:g6, "", "")
  " call s:h("BarbecueArray",            s:g6, "", "")
  " call s:h("BarbecueObject",           s:g6, "", "")
  " call s:h("BarbecueKey",              s:g6, "", "")
  " call s:h("BarbecueNull",             s:g6, "", "")
  " call s:h("BarbecueEnumMember",       s:g6, "", "")
  " call s:h("BarbecueStruct",           s:g6, "", "")
  " call s:h("BarbecueEvent",            s:g6, "", "")
  " call s:h("BarbecueOperator",         s:rd, "", "")
  " call s:h("BarbecueTypeParameter",    s:g6, "", "")
  " " }

  " Mason {
  call s:h("Mason",                            "", s:bg, "")
  call s:h("MasonMuted",                       s:g5, "", "")
  call s:h("MasonMutedBlock",                  "", s:g3, "")
  call s:h("MasonMutedBlockBold",              "", s:g3, "")
  call s:h("MasonHighlight",                   s:tl, "", "")
  call s:h("MasonHighlightMuted",              s:g5, "", "")
  call s:h("MasonHighlightMutedBlock",         "", s:g3, "")
  call s:h("MasonHighlightMutedBlockBold",     "", s:g3, "")
  call s:h("MasonNormal",                      "", s:bg, "")
  call s:h("MasonDoc",                         "", s:gn, "")
  call s:h("MasonHeader",                      s:bg, s:pe, "")
  call s:h("MasonHeaderSecondary",             s:bg, s:pe, "")
  call s:h("MasonError",                       s:bg, "", "")
  " call s:h("masonPod",                         s:rd, "", "")
  " call s:h("masonPerlComment",                 s:gn, "", "")
  call s:h("MasonHighlightBlockBoldSecondary", s:tl, s:g5, "")
  call s:h("MasonLink",                        s:cn, "", "")
  call s:h("MasonHeading",                     s:fg, "", "")
  call s:h("MasonHighlightBlock",              s:tl, "", "")
  call s:h("MasonHighlightBlockBold",          s:bg, s:tl, "")
  " call s:h("MasonHighlightSecondary",          s:bg, "", "")
  " call s:h("MasonHighlightBlockSecondary",     s:bg, "", "")

  " }

  " Noice {
  call s:h("NoiceCmdlinePopupBorder",       s:rd, s:bg, "")
  call s:h("NoiceCmdlineIcon",              s:rd, s:bg, "")
  call s:h("NoiceCmdlinePopupBorderSearch", s:be, s:bg, "")
  call s:h("NoiceCmdlineIconSearch",        s:be, s:bg, "")
  call s:h("NoiceCmdlinePopupBorderHelp",   s:pe, s:bg, "")
  call s:h("NoiceCmdlineIconHelp",          s:pe, s:bg, "")
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
augroup END

" neovim terminal {
if has('nvim')
  let g:terminal_color_0  = s:bg.gui
  let g:terminal_color_1  = s:rd.gui
  let g:terminal_color_2  = s:gn.gui
  let g:terminal_color_3  = s:yw.gui
  let g:terminal_color_4  = s:be.gui
  let g:terminal_color_5  = s:pe.gui
  let g:terminal_color_6  = s:cn.gui
  let g:terminal_color_7  = s:fg.gui
  let g:terminal_color_8  = s:g4.gui
  let g:terminal_color_9  = s:rd.gui
  let g:terminal_color_10 = s:gn.gui
  let g:terminal_color_11 = s:yw.gui
  let g:terminal_color_12 = s:be.gui
  let g:terminal_color_13 = s:pe.gui
  let g:terminal_color_14 = s:cn.gui
  let g:terminal_color_15 = s:fg.gui
  let g:terminal_color_background = s:bg.gui
  let g:terminal_color_foreground = s:fg.gui
endif
" }

if has("terminal") || has("nvim")
  let g:terminal_ansi_colors = [
        \ s:bg.gui,
        \ s:rd.gui,
        \ s:gn.gui,
        \ s:yw.gui,
        \ s:be.gui,
        \ s:pe.gui,
        \ s:cn.gui,
        \ s:fg.gui,
        \ s:g3.gui,
        \ s:rd.gui,
        \ s:gn.gui,
        \ s:yw.gui,
        \ s:be.gui,
        \ s:pe.gui,
        \ s:cn.gui,
        \ s:fg.gui
        \]
endif

