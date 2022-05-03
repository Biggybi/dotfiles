" base16-vim (https://github.com/chriskempson/base16-vim)
" by Chris Kempson (http://chriskempson.com)
" OneDark scheme by Lalit Magant (http://github.com/tilal6991)

" This enables the coresponding base16-shell script to run so that
" :colorscheme works in terminals supported by base16-shell scripts
" User must set this variable in .vimrc
"   let g:base16_shell_path=base16-builder/output/shell/
let s:colors_name = "base16-one-darkest"
let g:base16_one_darkest_shell = get(g:, 'base16_one_darkest_shell',
      \'$BASE16_PATH/' .. s:colors_name)
let g:base16_noshell = get(g:, 'base16_noshell', 0)

if !has("gui_running") && g:base16_noshell != 1 && v:vim_did_enter == 1
    execute "silent !source" g:base16_one_darkest_shell
endif

" GUI color definitions
let s:gui00     = "#131313"
let s:gui01     = "#202020"
let s:gui02     = "#303030"
let s:gui03     = "#454545"
let s:gui04     = "#565656"
let s:gui05     = "#7C7C7C"
" let s:gui06     = "#ee82ee"
let s:gui06     = "#b0b0b0"
let s:gui07     = "#c8ccd4"
let s:gui08     = "#ee6f6f"
let s:gui09     = "#d19a66"
let s:gui0A     = "#e5c07b"
let s:gui0B     = "#98c379"
let s:gui0C     = "#24a1c0"
let s:gui0D     = "#61afef"
let s:gui0E     = "#a470d4"
let s:gui0F     = "#be5046"

" Terminal color definitions
let s:cterm00   = "00"
let s:cterm03   = "236"
let s:cterm05   = "07"
let s:cterm07   = "15"
let s:cterm08   = "01"
let s:cterm0A   = "03"
let s:cterm0B   = "02"
let s:cterm0C   = "06"
let s:cterm0D   = "04"
let s:cterm0E   = "05"
" if exists("base16colorspace") && base16colorspace == "256"
if &t_Co >= 16
  let s:cterm01 = "18"
  let s:cterm02 = "19"
  let s:cterm04 = "20"
  let s:cterm06 = "21"
  let s:cterm09 = "16"
  let s:cterm0F = "17"
else
  let s:cterm01 = "10"
  let s:cterm02 = "11"
  let s:cterm04 = "12"
  let s:cterm06 = "13"
  let s:cterm09 = "09"
  let s:cterm0F = "14"
endif

if has("terminal") || has("nvim")
  let g:terminal_ansi_colors = [
        \ "#282c34",
        \ "#e06c75",
        \ "#98c379",
        \ "#e5c07b",
        \ "#61afef",
        \ "#c678dd",
        \ "#56b6c2",
        \ "#abb2bf",
        \ "#545862",
        \ "#e06c75",
        \ "#98c379",
        \ "#e5c07b",
        \ "#61afef",
        \ "#c678dd",
        \ "#56b6c2",
        \ "#c8ccd4",
        \ ]
endif

if has("nvim")
  function! s:Nvim_term_colors() abort
    let i = 0
    for term_color in g:terminal_ansi_colors
      exe printf("let g:terminal_color_%d = \"%s\"", i, term_color)
      let i = i + 1
    endfor
    if &background == "light"
      let g:terminal_color_background = g:terminal_color_7
      let g:terminal_color_foreground = g:terminal_color_2
    endif
  endfunction

  call <sid>Nvim_term_colors()
endif

" Theme setup
hi clear
syntax reset
let g:colors_name = s:colors_name

" Highlighting function
" Optional variables are attributes and guisp
function! g:Base16hi(group, fg, bg, at = '', sp = '')
  let guifg =   a:fg == "" ? "" : "guifg="   .. get(s:, "gui"   .. a:fg)
  let guibg =   a:bg == "" ? "" : "guibg="   .. get(s:, "gui"   .. a:bg)
  let ctermfg = a:fg == "" ? "" : "ctermfg=" .. get(s:, "cterm" .. a:fg)
  let ctermbg = a:bg == "" ? "" : "ctermbg=" .. get(s:, "cterm" .. a:bg)
  let sp =      a:sp == "" ? "" : "guisp="   .. get(s:, "gui"   .. a:sp)
  let at =      a:at == "" ? "" : "gui=" .. a:at .. " cterm=" .. a:at
  exe printf("hi %s %s %s %s %s %s %s",
        \a:group, guifg, guibg, ctermfg, ctermbg, at, sp)
endfunction

fun <sid>hi(group, fg, bg, attr, sp)
  call g:Base16hi(a:group, a:fg, a:bg, a:attr, a:sp)
endfun

function! s:hl()
  " Vim editor colors
  call <sid>hi("Normal",        "06", "00", "", "")
  call <sid>hi("Bold",          "", "", "bold", "")
  call <sid>hi("Debug",         "08", "", "", "")
  call <sid>hi("DebugPC",       "", "01", "", "")
  call <sid>hi("DebugBreakpoint", "08", "", "", "")
  call <sid>hi("Directory",     "0D", "", "", "")
  call <sid>hi("Error",         "07", "08", "", "")
  call <sid>hi("ErrorMsg",      "08", "00", "", "")
  call <sid>hi("TrailSpace",    "0C", "02", "strikethrough", "")
  call <sid>hi("Exception",     "08", "", "", "")
  call <sid>hi("FoldColumn",    "0C", "01", "", "")
  call <sid>hi("Folded",        "05", "00", "", "")
  call <sid>hi("Search",        "0D", "03",  "", "")
  call <sid>hi("IncSearch",     "0E", "03", "none", "")
  call <sid>hi("FirstSearch",   "0B", "03", "none", "")
  call <sid>hi("LastSearch",    "0A", "04", "none", "")
  call <sid>hi("Italic",        "", "", "none", "")
  call <sid>hi("Macro",         "08", "", "", "")
  call <sid>hi("MatchParen",    "0C", "02",  "", "")
  call <sid>hi("ModeMsg",       "0B", "", "", "")
  call <sid>hi("MoreMsg",       "0B", "", "", "")
  call <sid>hi("Question",      "0D", "", "", "")
  call <sid>hi("Substitute",    "01", "0A", "none", "")
  call <sid>hi("SpecialKey",    "04", "", "", "")
  call <sid>hi("TooLong",       "08", "", "", "")
  call <sid>hi("Underlined",    "08", "", "", "")
  call <sid>hi("Comment",       "05", "", "italic", "")
  call <sid>hi("Visual",        "", "02", "", "")
  call <sid>hi("VisualNOS",     "08", "", "", "")
  call <sid>hi("WarningMsg",    "08", "", "", "")
  call <sid>hi("WildMenu",      "00", "04", "", "")
  call <sid>hi("Title",         "0D", "", "none", "")
  call <sid>hi("Conceal",       "0A", "01", "", "")
  call <sid>hi("Ignore",        "04", "00", "", "")
  call <sid>hi("Cursor",        "00", "06", "", "")
  call <sid>hi("NonText",       "04", "", "", "")
  call <sid>hi("LineNr",        "04", "00", "", "")
  call <sid>hi("SignColumn",    "04", "00", "", "")
  " call <sid>hi("VertSplit",     "01", "01", "none", "")
  call <sid>hi("VertSplit",     "01", "00", "none", "")
  call <sid>hi("VertSplit2",    "02", "01", "none", "")
  " redline
  call <sid>hi("ColorColumn",   "", "01", "none", "")
  call <sid>hi("CursorColumn",  "", "02", "none", "")
  call <sid>hi("CursorLine",    "", "00", "none", "")
  call <sid>hi("CursorLineNr",  "06", "03", "none", "")
  call <sid>hi("EndOfBuffer",   "00", "00", "none", "")
  call <sid>hi("QuickFixLine",  "", "02", "none", "")
  call <sid>hi("PMenu",         "06", "02", "none", "")
  call <sid>hi("PMenuSel",      "06", "04", "", "")
  call <sid>hi("PMenuSbar",     "03", "04", "", "")
  call <sid>hi("PMenuThumb",    "00", "02", "", "")
  call <sid>hi("TabLine",       "06", "01", "none", "")
  call <sid>hi("TabLineFill",   "06", "00", "none", "")
  call <sid>hi("TabLineSel",    "06", "03", "none", "")

  " Status Line
  call <sid>hi("SuliGitSub",       "0C", "01", "none", "")
  call <sid>hi("SuliGit",          "0A", "01", "none", "")
  call <sid>hi("SuliGitMod",       "08", "03", "none", "")
  call <sid>hi("SuliFileMod",      "08", "01", "none", "")
  call <sid>hi("SuliCurDir",       "0C", "01", "none", "")
  call <sid>hi("SuliCmd",          "00", "08", "none", "")
  call <sid>hi("SuliFTSearch",     "00", "0C", "none", "")
  call <sid>hi("SuliPending",      "00", "0A", "none", "")
  call <sid>hi("SuliReplace",      "00", "06", "none", "")
  call <sid>hi("SuliVisual",       "00", "0E", "none", "")
  call <sid>hi("SuliInsert",       "00", "0B", "none", "")
  call <sid>hi("SuliNormal",       "00", "04", "none", "")
  call <sid>hi("SuliOuter",        "06", "03", "none", "")
  call <sid>hi("SuliMid",          "06", "01", "none", "")
  call <sid>hi("SuliSep",          "00", "01", "none", "")
  call <sid>hi("StatusLineTermNC", "04", "01", "none", "")
  call <sid>hi("StatusLineTerm",   "06", "01", "none", "")
  call <sid>hi("StatuslineNC",     "04", "01", "none", "")
  call <sid>hi("StatusLine",       "06", "01", "none", "")
  call <sid>hi("Ruler",            "0A", "0B", "none", "")

  " Standard syntax highlighting
  call <sid>hi("Boolean",      "09", "", "", "")
  call <sid>hi("Character",    "0B", "", "", "")
  " call <sid>hi("Conditional",  "66", "", "", "")
  call <sid>hi("Constant",     "09", "", "", "")
  call <sid>hi("Define",       "0E", "", "none", "")
  call <sid>hi("Delimiter",    "0F", "", "", "")
  call <sid>hi("Float",        "09", "", "", "")
  call <sid>hi("Function",     "0D", "", "", "")
  call <sid>hi("Identifier",   "08", "", "none", "")
  call <sid>hi("Include",      "0D", "", "", "")
  call <sid>hi("Keyword",      "0E", "", "", "")
  call <sid>hi("Label",        "0A", "", "", "")
  call <sid>hi("Number",       "09", "", "", "")
  call <sid>hi("Operator",     "06", "", "none", "")
  call <sid>hi("PreProc",      "0A", "", "", "")
  " call <sid>hi("Repeat",       "66", "", "", "")
  call <sid>hi("Special",      "0C", "", "", "")
  call <sid>hi("SpecialChar",  "0F", "", "", "")
  call <sid>hi("Statement",    "0E", "", "", "")
  call <sid>hi("StorageClass", "0A", "", "", "")
  call <sid>hi("String",       "0B", "", "", "")
  call <sid>hi("Structure",    "0E", "", "", "")
  call <sid>hi("Tag",          "0A", "", "", "")
  call <sid>hi("Todo",         "0C", "00", "", "")
  call <sid>hi("Type",         "0B", "", "none", "")
  call <sid>hi("Type",         "0A", "", "none", "")
  call <sid>hi("Typedef",      "0A", "", "", "")

  " QuickFix
  call <sid>hi("qfError",   "09", "00", "", "")

  " C highlighting
  call <sid>hi("cOperator",         "0C", "", "", "")
  call <sid>hi("cPreCondit",        "0E", "", "", "")
  call <sid>hi("cDefine",           "0E", "", "", "")
  call <sid>hi("cCustomMacro",      "0C", "", "", "")
  call <sid>hi("cInclude",          "0C", "", "", "")
  call <sid>hi("cStructureMember",  "08", "", "", "")
  " call <sid>hi("cStorageClass",     "08", "", "", "")
  " call <sid>hi("cParen",            "0A", "", "", "")
  " call <sid>hi("cBlock",            "0A", "", "", "")
  " cStructureMember cParen cBlock cBlock cBlock
  " C++
  call <sid>hi("cppStructure",    "0E", "", "", "")

  " C# highlighting
  call <sid>hi("csClassStorage",          "0E", "", "", "")
  call <sid>hi("csClass",                 "0E", "", "", "")
  call <sid>hi("csClassType",             "0A", "", "", "")
  call <sid>hi("csAttribute",             "0A", "", "", "")
  call <sid>hi("csModifier",              "0E", "", "", "")
  call <sid>hi("csType",                  "0E", "", "", "")
  call <sid>hi("csUnspecifiedStatement",  "0D", "", "", "")
  call <sid>hi("csContextualStatement",   "0E", "", "", "")
  call <sid>hi("csNewDecleration",        "08", "", "", "")

  " CSS highlighting
  call <sid>hi("cssBraces",      "06", "", "", "")
  call <sid>hi("cssClassName",   "0E", "", "", "")
  call <sid>hi("cssColor",       "0C", "", "", "")

  " Diff highlighting
  call <sid>hi("DiffAdd",      "0B", "00", "", "")
  call <sid>hi("DiffChange",   "04", "00", "", "")
  call <sid>hi("DiffDelete",   "08", "00", "", "")
  call <sid>hi("DiffText",     "0D", "00", "", "")
  call <sid>hi("DiffAdded",    "0B", "00", "", "")
  call <sid>hi("DiffFile",     "08", "00", "", "")
  call <sid>hi("DiffNewFile",  "0B", "00", "", "")
  call <sid>hi("DiffLine",     "0D", "00", "", "")
  call <sid>hi("DiffRemoved",  "08", "00", "", "")

  " Git highlighting
  call <sid>hi("gitcommitOverflow",       "08", "", "", "")
  call <sid>hi("gitcommitSummary",        "0B", "", "", "")
  call <sid>hi("gitcommitComment",        "04", "", "", "")
  call <sid>hi("gitcommitUntracked",      "04", "", "", "")
  call <sid>hi("gitcommitDiscarded",      "04", "", "", "")
  call <sid>hi("gitcommitSelected",       "04", "", "", "")
  call <sid>hi("gitcommitHeader",         "0E", "", "", "")
  call <sid>hi("gitcommitSelectedType",   "0D", "", "", "")
  call <sid>hi("gitcommitUnmergedType",   "0D", "", "", "")
  call <sid>hi("gitcommitDiscardedType",  "0D", "", "", "")
  call <sid>hi("gitcommitBranch",         "09", "", "bold", "")
  call <sid>hi("gitcommitUntrackedFile",  "0A", "", "", "")
  call <sid>hi("gitcommitUnmergedFile",   "08", "", "bold", "")
  call <sid>hi("gitcommitDiscardedFile",  "08", "", "bold", "")
  call <sid>hi("gitcommitSelectedFile",   "0B", "", "bold", "")

  " GitGutter highlighting
  call <sid>hi("GitGutterAdd",           "0B", "00", "bold", "")
  call <sid>hi("GitGutterChange",        "0C", "00", "bold", "")
  call <sid>hi("GitGutterDelete",        "08", "00", "bold", "")
  call <sid>hi("GitGutterChangeDelete",  "0E", "00", "bold", "")

  " HTML highlighting
  call <sid>hi("htmlBold",    "0A", "", "", "")
  call <sid>hi("htmlItalic",  "0E", "", "", "")
  call <sid>hi("htmlEndTag",  "06", "", "", "")
  call <sid>hi("htmlTag",     "06", "", "", "")

  " JavaScript highlighting
  call <sid>hi("javaScript",          "06", "", "", "")
  call <sid>hi("javaScriptBraces",    "06", "", "", "")
  call <sid>hi("javaScriptNumber",    "09", "", "", "")
  " pangloss/vim-javascript highlighting
  call <sid>hi("jsOperator",          "0D", "", "", "")
  call <sid>hi("jsStatement",         "0E", "", "", "")
  call <sid>hi("jsReturn",            "0E", "", "", "")
  call <sid>hi("jsThis",              "08", "", "", "")
  call <sid>hi("jsClassDefinition",   "0A", "", "", "")
  call <sid>hi("jsFunction",          "0E", "", "", "")
  call <sid>hi("jsFuncName",          "0D", "", "", "")
  call <sid>hi("jsFuncCall",          "0D", "", "", "")
  call <sid>hi("jsClassFuncName",     "0D", "", "", "")
  call <sid>hi("jsClassMethodType",   "0E", "", "", "")
  call <sid>hi("jsRegexpString",      "0C", "", "", "")
  call <sid>hi("jsGlobalObjects",     "0A", "", "", "")
  call <sid>hi("jsGlobalNodeObjects", "0A", "", "", "")
  call <sid>hi("jsExceptions",        "0A", "", "", "")
  call <sid>hi("jsBuiltins",          "0A", "", "", "")

  " Mail highlighting
  call <sid>hi("mailQuoted1",  "0A", "", "", "")
  call <sid>hi("mailQuoted2",  "0B", "", "", "")
  call <sid>hi("mailQuoted3",  "0E", "", "", "")
  call <sid>hi("mailQuoted4",  "0C", "", "", "")
  call <sid>hi("mailQuoted5",  "0D", "", "", "")
  call <sid>hi("mailQuoted6",  "0A", "", "", "")
  call <sid>hi("mailURL",      "0D", "", "", "")
  call <sid>hi("mailEmail",    "0D", "", "", "")

  " Markdown highlighting
  call <sid>hi("markdownCode",              "0B", "", "", "")
  call <sid>hi("markdownError",             "06", "00", "", "")
  call <sid>hi("markdownCodeBlock",         "0B", "", "", "")
  call <sid>hi("markdownHeadingDelimiter",  "0D", "", "", "")

  " NERDTree highlighting
  call <sid>hi("NERDTreeDirSlash",  "0D", "", "", "")
  call <sid>hi("NERDTreeExecFile",  "06", "", "", "")

  " PHP highlighting
  call <sid>hi("phpMemberSelector",  "06", "", "", "")
  call <sid>hi("phpComparison",      "06", "", "", "")
  call <sid>hi("phpParent",          "06", "", "", "")
  call <sid>hi("phpMethodsVar",      "0C", "", "", "")

  " Python highlighting
  call <sid>hi("pythonOperator",  "0E", "", "", "")
  call <sid>hi("pythonRepeat",    "0E", "", "", "")
  call <sid>hi("pythonInclude",   "0E", "", "", "")
  call <sid>hi("pythonStatement", "0E", "", "", "")

  " Ruby highlighting
  call <sid>hi("rubyAttribute",               "0D", "", "", "")
  call <sid>hi("rubyConstant",                "0A", "", "", "")
  call <sid>hi("rubyInterpolationDelimiter",  "0F", "", "", "")
  call <sid>hi("rubyRegexp",                  "0C", "", "", "")
  call <sid>hi("rubySymbol",                  "0B", "", "", "")
  call <sid>hi("rubyStringDelimiter",         "0B", "", "", "")

  " SASS highlighting
  call <sid>hi("sassidChar",     "08", "", "", "")
  call <sid>hi("sassClassChar",  "09", "", "", "")
  call <sid>hi("sassInclude",    "0E", "", "", "")
  call <sid>hi("sassMixing",     "0E", "", "", "")
  call <sid>hi("sassMixinName",  "0D", "", "", "")

  " Signify highlighting
  call <sid>hi("SignifySignAdd",     "0B", "01", "", "")
  call <sid>hi("SignifySignChange",  "0D", "01", "", "")
  call <sid>hi("SignifySignDelete",  "08", "01", "", "")

  " Spelling highlighting
  call <sid>hi("SpellBad",   "01", "08", "undercurl", "08")
  call <sid>hi("SpellLocal", "", "", "undercurl", "0C")
  call <sid>hi("SpellCap",   "", "", "undercurl", "0D")
  call <sid>hi("SpellRare",  "", "", "undercurl", "0E")

  " Startify highlighting
  call <sid>hi("StartifyBracket",  "04", "", "", "")
  call <sid>hi("StartifyFile",     "07", "", "", "")
  call <sid>hi("StartifyFooter",   "04", "", "", "")
  call <sid>hi("StartifyHeader",   "0B", "", "", "")
  call <sid>hi("StartifyNumber",   "09", "", "", "")
  call <sid>hi("StartifyPath",     "04", "", "", "")
  call <sid>hi("StartifySection",  "0E", "", "", "")
  call <sid>hi("StartifySelect",   "0C", "", "", "")
  call <sid>hi("StartifySlash",    "04", "", "", "")
  call <sid>hi("StartifySpecial",  "04", "", "", "")

  " Coc highlighting
  " call <sid>hi("CocHighlightText", "", "01", "", "")
  call <sid>hi("CocSelectedLine", "0E", "0A", "", "")
  call <sid>hi("CocSelectedText", "0E", "0A", "", "")
  call <sid>hi("CocListMode", "0B", "03", "", "")
  call <sid>hi("CocListPath", "04", "01", "", "")

  " Java highlighting
  call <sid>hi("javaOperator",     "0D", "", "", "")
  call <sid>hi("javaTypedef",     "0B", "", "", "")

  " User Groups defaults
  hi link User1 SuliNormal
  hi link User2 SuliOuter
  hi link User3 SuliMid
  hi link User4 SuliGitMod
  hi link User5 SuliFileMod
  hi link User6 SuliCurDir
  hi link User7 SuliGit
  hi link User8 SuliGitSub
  hi link User9 SuliSep
endfunction
call s:hl()

augroup OnedarkestHL
  au!
  au ColorScheme <amatch> call s:hl()
augroup end

" Remove functions
delf <sid>hi

" Remove color variables
unlet s:gui00 s:gui01 s:gui02 s:gui03  s:gui04  s:gui05  s:gui06  s:gui07  s:gui08  s:gui09 s:gui0A  s:gui0B  s:gui0C  s:gui0D  s:gui0E  s:gui0F
unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03 s:cterm04 s:cterm05 s:cterm06 s:cterm07 s:cterm08 s:cterm09 s:cterm0A s:cterm0B s:cterm0C s:cterm0D s:cterm0E s:cterm0F
