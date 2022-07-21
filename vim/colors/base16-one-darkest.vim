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

  call s:Nvim_term_colors()
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
  call s:hi("Normal",        "06", "00", "", "")
  call s:hi("Bold",          "", "", "bold", "")
  call s:hi("Debug",         "08", "", "", "")
  call s:hi("DebugPC",       "", "01", "", "")
  call s:hi("DebugBreakpoint", "08", "", "", "")
  call s:hi("Directory",     "0D", "", "", "")
  call s:hi("Error",         "07", "08", "", "")
  call s:hi("ErrorMsg",      "08", "00", "", "")
  call s:hi("TrailSpace",    "0C", "02", "strikethrough", "")
  call s:hi("Exception",     "08", "", "", "")
  call s:hi("FoldColumn",    "0C", "01", "", "")
  call s:hi("Folded",        "05", "00", "", "")
  call s:hi("Search",        "0D", "03",  "", "")
  call s:hi("IncSearch",     "0E", "03", "none", "")
  call s:hi("FirstSearch",   "0B", "03", "none", "")
  call s:hi("LastSearch",    "0A", "04", "none", "")
  call s:hi("Italic",        "", "", "none", "")
  call s:hi("Macro",         "08", "", "", "")
  call s:hi("MatchParen",    "0C", "02",  "", "")
  call s:hi("ModeMsg",       "0B", "", "", "")
  call s:hi("MoreMsg",       "0B", "", "", "")
  call s:hi("Question",      "0D", "", "", "")
  call s:hi("Substitute",    "01", "0A", "none", "")
  call s:hi("SpecialKey",    "04", "", "", "")
  call s:hi("TooLong",       "08", "", "", "")
  call s:hi("Underlined",    "08", "", "", "")
  call s:hi("Comment",       "05", "", "italic", "")
  call s:hi("Visual",        "", "02", "", "")
  call s:hi("VisualNOS",     "08", "", "", "")
  call s:hi("WarningMsg",    "08", "", "", "")
  call s:hi("WildMenu",      "00", "04", "", "")
  call s:hi("Title",         "0D", "", "none", "")
  call s:hi("Conceal",       "0A", "01", "", "")
  call s:hi("Ignore",        "04", "00", "", "")
  call s:hi("Cursor",        "00", "06", "", "")
  call s:hi("NonText",       "04", "", "", "")
  call s:hi("LineNr",        "04", "00", "", "")
  call s:hi("SignColumn",    "04", "00", "", "")
  " call s:hi("VertSplit",     "01", "01", "none", "")
  call s:hi("VertSplit",     "01", "00", "none", "")
  call s:hi("VertSplit2",    "02", "01", "none", "")
  " redline
  call s:hi("ColorColumn",   "", "01", "none", "")
  call s:hi("CursorColumn",  "", "02", "none", "")
  call s:hi("CursorLine",    "", "00", "none", "")
  call s:hi("CursorLineNr",  "06", "03", "none", "")
  call s:hi("EndOfBuffer",   "00", "00", "none", "")
  call s:hi("QuickFixLine",  "", "02", "none", "")
  call s:hi("PMenu",         "06", "02", "none", "")
  call s:hi("PMenuSel",      "06", "04", "", "")
  call s:hi("PMenuSbar",     "03", "04", "", "")
  call s:hi("PMenuThumb",    "00", "02", "", "")
  call s:hi("TabLine",       "06", "01", "none", "")
  call s:hi("TabLineFill",   "06", "00", "none", "")
  call s:hi("TabLineSel",    "06", "03", "none", "")

  " Status Line
  call s:hi("SuliGitSub",       "0C", "01", "none", "")
  call s:hi("SuliGit",          "0A", "01", "none", "")
  call s:hi("SuliGitMod",       "08", "03", "none", "")
  call s:hi("SuliFileMod",      "08", "01", "none", "")
  call s:hi("SuliCurDir",       "0C", "01", "none", "")
  call s:hi("SuliCmd",          "00", "08", "none", "")
  call s:hi("SuliFTSearch",     "00", "0C", "none", "")
  call s:hi("SuliPending",      "00", "0A", "none", "")
  call s:hi("SuliReplace",      "00", "06", "none", "")
  call s:hi("SuliVisual",       "00", "0E", "none", "")
  call s:hi("SuliInsert",       "00", "0B", "none", "")
  call s:hi("SuliNormal",       "00", "04", "none", "")
  call s:hi("SuliOuter",        "06", "03", "none", "")
  call s:hi("SuliMid",          "06", "01", "none", "")
  call s:hi("SuliSep",          "00", "01", "none", "")
  call s:hi("StatusLineTermNC", "04", "01", "none", "")
  call s:hi("StatusLineTerm",   "06", "01", "none", "")
  call s:hi("StatuslineNC",     "04", "01", "none", "")
  call s:hi("StatusLine",       "06", "01", "none", "")
  call s:hi("Ruler",            "0A", "0B", "none", "")

  " Standard syntax highlighting
  call s:hi("Boolean",      "09", "", "", "")
  call s:hi("Character",    "0B", "", "", "")
  " call s:hi("Conditional",  "66", "", "", "")
  call s:hi("Constant",     "09", "", "", "")
  call s:hi("Define",       "0E", "", "none", "")
  call s:hi("Delimiter",    "0F", "", "", "")
  call s:hi("Float",        "09", "", "", "")
  call s:hi("Function",     "0D", "", "", "")
  call s:hi("Identifier",   "08", "", "none", "")
  call s:hi("Include",      "0D", "", "", "")
  call s:hi("Keyword",      "0E", "", "", "")
  call s:hi("Label",        "0A", "", "", "")
  call s:hi("Number",       "09", "", "", "")
  call s:hi("Operator",     "06", "", "none", "")
  call s:hi("PreProc",      "0A", "", "", "")
  " call s:hi("Repeat",       "66", "", "", "")
  call s:hi("Special",      "0C", "", "", "")
  call s:hi("SpecialChar",  "0F", "", "", "")
  call s:hi("Statement",    "0E", "", "", "")
  call s:hi("StorageClass", "0A", "", "", "")
  call s:hi("String",       "0B", "", "", "")
  call s:hi("Structure",    "0E", "", "", "")
  call s:hi("Tag",          "0A", "", "", "")
  call s:hi("Todo",         "0C", "00", "", "")
  call s:hi("Type",         "0B", "", "none", "")
  call s:hi("Type",         "0A", "", "none", "")
  call s:hi("Typedef",      "0A", "", "", "")

  " QuickFix
  call s:hi("qfError",   "09", "00", "", "")

  " C highlighting
  call s:hi("cOperator",         "0C", "", "", "")
  call s:hi("cPreCondit",        "0E", "", "", "")
  call s:hi("cDefine",           "0E", "", "", "")
  call s:hi("cCustomMacro",      "0C", "", "", "")
  call s:hi("cInclude",          "0C", "", "", "")
  call s:hi("cStructureMember",  "08", "", "", "")
  " call s:hi("cStorageClass",     "08", "", "", "")
  " call s:hi("cParen",            "0A", "", "", "")
  " call s:hi("cBlock",            "0A", "", "", "")
  " cStructureMember cParen cBlock cBlock cBlock
  " C++
  call s:hi("cppStructure",    "0E", "", "", "")

  " C# highlighting
  call s:hi("csClassStorage",          "0E", "", "", "")
  call s:hi("csClass",                 "0E", "", "", "")
  call s:hi("csClassType",             "0A", "", "", "")
  call s:hi("csAttribute",             "0A", "", "", "")
  call s:hi("csModifier",              "0E", "", "", "")
  call s:hi("csType",                  "0E", "", "", "")
  call s:hi("csUnspecifiedStatement",  "0D", "", "", "")
  call s:hi("csContextualStatement",   "0E", "", "", "")
  call s:hi("csNewDecleration",        "08", "", "", "")

  " CSS highlighting
  call s:hi("cssBraces",      "06", "", "", "")
  call s:hi("cssClassName",   "0E", "", "", "")
  call s:hi("cssColor",       "0C", "", "", "")

  " Diff highlighting
  call s:hi("DiffAdd",      "0B", "00", "", "")
  call s:hi("DiffChange",   "04", "00", "", "")
  call s:hi("DiffDelete",   "08", "00", "", "")
  call s:hi("DiffText",     "0D", "00", "", "")
  call s:hi("DiffAdded",    "0B", "00", "", "")
  call s:hi("DiffFile",     "08", "00", "", "")
  call s:hi("DiffNewFile",  "0B", "00", "", "")
  call s:hi("DiffLine",     "0D", "00", "", "")
  call s:hi("DiffRemoved",  "08", "00", "", "")

  " Git highlighting
  call s:hi("gitcommitOverflow",       "08", "", "", "")
  call s:hi("gitcommitSummary",        "0B", "", "", "")
  call s:hi("gitcommitComment",        "04", "", "", "")
  call s:hi("gitcommitUntracked",      "04", "", "", "")
  call s:hi("gitcommitDiscarded",      "04", "", "", "")
  call s:hi("gitcommitSelected",       "04", "", "", "")
  call s:hi("gitcommitHeader",         "0E", "", "", "")
  call s:hi("gitcommitSelectedType",   "0D", "", "", "")
  call s:hi("gitcommitUnmergedType",   "0D", "", "", "")
  call s:hi("gitcommitDiscardedType",  "0D", "", "", "")
  call s:hi("gitcommitBranch",         "09", "", "bold", "")
  call s:hi("gitcommitUntrackedFile",  "0A", "", "", "")
  call s:hi("gitcommitUnmergedFile",   "08", "", "bold", "")
  call s:hi("gitcommitDiscardedFile",  "08", "", "bold", "")
  call s:hi("gitcommitSelectedFile",   "0B", "", "bold", "")

  " GitGutter highlighting
  call s:hi("GitGutterAdd",           "0B", "00", "bold", "")
  call s:hi("GitGutterChange",        "0C", "00", "bold", "")
  call s:hi("GitGutterDelete",        "08", "00", "bold", "")
  call s:hi("GitGutterChangeDelete",  "0E", "00", "bold", "")

  " HTML highlighting
  call s:hi("htmlBold",    "0A", "", "", "")
  call s:hi("htmlItalic",  "0E", "", "", "")
  call s:hi("htmlEndTag",  "06", "", "", "")
  call s:hi("htmlTag",     "06", "", "", "")

  " JavaScript highlighting
  call s:hi("javaScript",          "06", "", "", "")
  call s:hi("javaScriptBraces",    "06", "", "", "")
  call s:hi("javaScriptNumber",    "09", "", "", "")
  " pangloss/vim-javascript highlighting
  call s:hi("jsOperator",          "0D", "", "", "")
  call s:hi("jsStatement",         "0E", "", "", "")
  call s:hi("jsReturn",            "0E", "", "", "")
  call s:hi("jsThis",              "08", "", "", "")
  call s:hi("jsClassDefinition",   "0A", "", "", "")
  call s:hi("jsFunction",          "0E", "", "", "")
  call s:hi("jsFuncName",          "0D", "", "", "")
  call s:hi("jsFuncCall",          "0D", "", "", "")
  call s:hi("jsClassFuncName",     "0D", "", "", "")
  call s:hi("jsClassMethodType",   "0E", "", "", "")
  call s:hi("jsRegexpString",      "0C", "", "", "")
  call s:hi("jsGlobalObjects",     "0A", "", "", "")
  call s:hi("jsGlobalNodeObjects", "0A", "", "", "")
  call s:hi("jsExceptions",        "0A", "", "", "")
  call s:hi("jsBuiltins",          "0A", "", "", "")

  " Mail highlighting
  call s:hi("mailQuoted1",  "0A", "", "", "")
  call s:hi("mailQuoted2",  "0B", "", "", "")
  call s:hi("mailQuoted3",  "0E", "", "", "")
  call s:hi("mailQuoted4",  "0C", "", "", "")
  call s:hi("mailQuoted5",  "0D", "", "", "")
  call s:hi("mailQuoted6",  "0A", "", "", "")
  call s:hi("mailURL",      "0D", "", "", "")
  call s:hi("mailEmail",    "0D", "", "", "")

  " Markdown highlighting
  call s:hi("markdownCode",              "0B", "", "", "")
  call s:hi("markdownError",             "06", "00", "", "")
  call s:hi("markdownCodeBlock",         "0B", "", "", "")
  call s:hi("markdownHeadingDelimiter",  "0D", "", "", "")

  " NERDTree highlighting
  call s:hi("NERDTreeDirSlash",  "0D", "", "", "")
  call s:hi("NERDTreeExecFile",  "06", "", "", "")

  " PHP highlighting
  call s:hi("phpMemberSelector",  "06", "", "", "")
  call s:hi("phpComparison",      "06", "", "", "")
  call s:hi("phpParent",          "06", "", "", "")
  call s:hi("phpMethodsVar",      "0C", "", "", "")

  " Python highlighting
  call s:hi("pythonOperator",  "0E", "", "", "")
  call s:hi("pythonRepeat",    "0E", "", "", "")
  call s:hi("pythonInclude",   "0E", "", "", "")
  call s:hi("pythonStatement", "0E", "", "", "")

  " Ruby highlighting
  call s:hi("rubyAttribute",               "0D", "", "", "")
  call s:hi("rubyConstant",                "0A", "", "", "")
  call s:hi("rubyInterpolationDelimiter",  "0F", "", "", "")
  call s:hi("rubyRegexp",                  "0C", "", "", "")
  call s:hi("rubySymbol",                  "0B", "", "", "")
  call s:hi("rubyStringDelimiter",         "0B", "", "", "")

  " SASS highlighting
  call s:hi("sassidChar",     "08", "", "", "")
  call s:hi("sassClassChar",  "09", "", "", "")
  call s:hi("sassInclude",    "0E", "", "", "")
  call s:hi("sassMixing",     "0E", "", "", "")
  call s:hi("sassMixinName",  "0D", "", "", "")

  " Signify highlighting
  call s:hi("SignifySignAdd",     "0B", "01", "", "")
  call s:hi("SignifySignChange",  "0D", "01", "", "")
  call s:hi("SignifySignDelete",  "08", "01", "", "")

  " Spelling highlighting
  call s:hi("SpellBad",   "01", "08", "undercurl", "08")
  call s:hi("SpellLocal", "", "", "undercurl", "0C")
  call s:hi("SpellCap",   "", "", "undercurl", "0D")
  call s:hi("SpellRare",  "", "", "undercurl", "0E")

  " Startify highlighting
  call s:hi("StartifyBracket",  "04", "", "", "")
  call s:hi("StartifyFile",     "07", "", "", "")
  call s:hi("StartifyFooter",   "04", "", "", "")
  call s:hi("StartifyHeader",   "0B", "", "", "")
  call s:hi("StartifyNumber",   "09", "", "", "")
  call s:hi("StartifyPath",     "04", "", "", "")
  call s:hi("StartifySection",  "0E", "", "", "")
  call s:hi("StartifySelect",   "0C", "", "", "")
  call s:hi("StartifySlash",    "04", "", "", "")
  call s:hi("StartifySpecial",  "04", "", "", "")

  " Coc highlighting
  " call s:hi("CocHighlightText", "", "01", "", "")
  call s:hi("CocSelectedLine", "0E", "0A", "", "")
  call s:hi("CocSelectedText", "0E", "0A", "", "")
  call s:hi("CocListMode", "0B", "03", "", "")
  call s:hi("CocListPath", "04", "01", "", "")

  " Java highlighting
  call s:hi("javaOperator",     "0D", "", "", "")
  call s:hi("javaTypedef",     "0B", "", "", "")

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
