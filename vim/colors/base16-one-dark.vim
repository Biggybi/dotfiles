" vi:syntax=vim
" base16-vim (https://github.com/chriskempson/base16-vim)
" by Chris Kempson (http://chriskempson.com)
" OneDark scheme by Lalit Magant (http://github.com/tilal6991)

" This enables the coresponding base16-shell script to run so that
" :colorscheme works in terminals supported by base16-shell scripts
" User must set this variable in .vimrc
"   let g:base16_shell_path=base16-builder/output/shell/
let g:base16_one_dark_shell = get(g:, 'base16_one_dark_shell',
      \'~/dotfiles/shells/themes/base16/base16-one-dark')
let g:base16_noshell = get(g:, 'base16_noshell', '0')
if !has("gui_running") && g:base16_noshell != 1
  if readfile('/home/tris/.config/base16_theme')[0]
        \!= matchstr(g:base16_one_dark_shell, '[^/]*$')
    execute "silent !source" g:base16_one_dark_shell
  endif
endif

" GUI color definitions
let s:gui00        = "#2C2C2C"
let s:gui01        = "#363636"
let s:gui02        = "#454545"
let s:gui03        = "#7C7C7C"
let s:gui04        = "#565656"
let s:gui05        = "#b4b4b4"
let s:gui06        = "#ee82ee"
let s:gui07        = "#c8ccd4"
let s:gui08        = "#ee6f6f"
let s:gui09        = "#d19a66"
let s:gui0A        = "#e5c07b"
let s:gui0B        = "#98c379"
let s:gui0C        = "#24a1c0"
let s:gui0D        = "#61afef"
let s:gui0E        = "#a470d4"
let s:gui0F        = "#be5046"

" Terminal color definitions
let s:cterm00        = "00"
let s:cterm03        = "08"
let s:cterm05        = "07"
let s:cterm07        = "15"
let s:cterm08        = "01"
let s:cterm0A        = "03"
let s:cterm0B        = "02"
let s:cterm0C        = "06"
let s:cterm0D        = "04"
let s:cterm0E        = "05"
if exists("base16colorspace") && base16colorspace == "256"
  let s:cterm01        = "18"
  let s:cterm02        = "19"
  let s:cterm04        = "20"
  let s:cterm06        = "21"
  let s:cterm09        = "16"
  let s:cterm0F        = "17"
else
  let s:cterm01        = "10"
  let s:cterm02        = "11"
  let s:cterm04        = "12"
  let s:cterm06        = "13"
  let s:cterm09        = "09"
  let s:cterm0F        = "14"
endif


" Neovim terminal colours
if has("nvim")
  let g:terminal_color_0 =  "#282c34"
  let g:terminal_color_1 =  "#e06c75"
  let g:terminal_color_2 =  "#98c379"
  let g:terminal_color_3 =  "#e5c07b"
  let g:terminal_color_4 =  "#61afef"
  let g:terminal_color_5 =  "#c678dd"
  let g:terminal_color_6 =  "#56b6c2"
  let g:terminal_color_7 =  "#abb2bf"
  let g:terminal_color_8 =  "#545862"
  let g:terminal_color_9 =  "#e06c75"
  let g:terminal_color_10 = "#98c379"
  let g:terminal_color_11 = "#e5c07b"
  let g:terminal_color_12 = "#61afef"
  let g:terminal_color_13 = "#c678dd"
  let g:terminal_color_14 = "#56b6c2"
  let g:terminal_color_15 = "#c8ccd4"
  let g:terminal_color_background = g:terminal_color_0
  let g:terminal_color_foreground = g:terminal_color_5
elseif has("terminal")
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

" Theme setup
hi clear
syntax reset
let g:colors_name = "base16-one-dark"

" Highlighting function
" Optional variables are attributes and guisp
function! g:Base16hi(group, guifg, guibg, attr = '', guisp = '')
  let fg = a:guifg == "" ? "" :       "guifg=" .. a:guifg
  let bg = a:guibg == "" ? "" :       "guibg=" .. a:guibg
  let attrib = a:attr == "" ? "" :    "gui=" .. a:attr .. " cterm=" .. a:attr
  let sp = a:guisp == "" ? "" :       "guisp=" .. a:guisp
  exec printf("hi %s %s %s %s %s %s %s",
        \a:group, fg, bg, fg, bg, attrib, sp)
endfunction

fun <sid>hi(group, guifg, guibg, attr, guisp)
  call g:Base16hi(a:group, a:guifg, a:guibg, a:attr, a:guisp)
endfun

" Vim editor colors
call <sid>hi("Normal",        s:gui05, s:gui00, "", "")
call <sid>hi("Bold",          "", "", "bold", "")
call <sid>hi("Debug",         s:gui08, "", "", "")
call <sid>hi("DebugPC",       "", s:gui01, "", "")
call <sid>hi("DebugBreakpoint", s:gui08, "", "", "")
call <sid>hi("Directory",     s:gui0D, "", "", "")
call <sid>hi("Error",         s:gui07, s:gui08, "", "")
call <sid>hi("ErrorMsg",      s:gui08, s:gui00, "", "")
call <sid>hi("TrailSpace",    s:gui0C, s:gui02, "strikethrough", "")
call <sid>hi("Exception",     s:gui08, "", "", "")
call <sid>hi("FoldColumn",    s:gui0C, s:gui01, "", "")
call <sid>hi("Folded",        s:gui03, s:gui00, "", "")
call <sid>hi("Search",        s:gui02, s:gui0A,  "", "")
call <sid>hi("IncSearch",     s:gui02, s:gui0B, "none", "")
" call <sid>hi("FirstSearch",    s:gui02, s:gui0D, "none", "")
" call <sid>hi("LastSearch",    s:gui02, s:gui08, "none", "")
call <sid>hi("Italic",        "", "", "none", "")
call <sid>hi("Macro",         s:gui08, "", "", "")
call <sid>hi("MatchParen",    s:gui0C, s:gui02,  "", "")
call <sid>hi("ModeMsg",       s:gui0B, "", "", "")
call <sid>hi("MoreMsg",       s:gui0B, "", "", "")
call <sid>hi("Question",      s:gui0D, "", "", "")
call <sid>hi("Substitute",    s:gui01, s:gui0A, "none", "")
call <sid>hi("SpecialKey",    s:gui02, "", "", "")
call <sid>hi("TooLong",       s:gui08, "", "", "")
call <sid>hi("Underlined",    s:gui08, "", "", "")
call <sid>hi("Comment",       s:gui03, "", "italic", "")
call <sid>hi("Visual",        "", s:gui02, "", "")
call <sid>hi("VisualNOS",     s:gui08, "", "", "")
call <sid>hi("WarningMsg",    s:gui08, "", "", "")
call <sid>hi("WildMenu",      s:gui00, s:gui03, "", "")
call <sid>hi("Title",         s:gui0D, "", "none", "")
call <sid>hi("Conceal",       s:gui0A, s:gui01, "", "")
call <sid>hi("Ignore",        s:gui03, s:gui00, "", "")
call <sid>hi("Cursor",        s:gui00, s:gui05, "", "")
call <sid>hi("NonText",       s:gui03, "", "", "")
call <sid>hi("LineNr",         s:gui03, s:gui00, "", "")
call <sid>hi("SignColumn",     s:gui03, s:gui00, "", "")
" call <sid>hi("VertSplit",     s:gui01, s:gui01, "none", "")
call <sid>hi("VertSplit",      s:gui01, s:gui00, "none", "")
call <sid>hi("VertSplit2",     s:gui02, s:gui01, "none", "")
" redline
call <sid>hi("ColorColumn",   "", s:gui01, "none", "")
call <sid>hi("CursorColumn",  "", s:gui02, "none", "")
call <sid>hi("CursorLine",    "", s:gui00, "none", "")
call <sid>hi("CursorLineNr",  s:gui05, s:gui04, "none", "")
call <sid>hi("EndOfBuffer",   s:gui00, s:gui00, "none", "")
call <sid>hi("QuickFixLine",  "", s:gui02, "none", "")
call <sid>hi("PMenu",         s:gui05, s:gui01, "none", "")
call <sid>hi("PMenuSel",      s:gui05, s:gui02, "", "")
call <sid>hi("PMenuSbar",     s:gui04, s:gui02, "", "")
call <sid>hi("PMenuThumb",    s:gui00, s:gui01, "", "")
call <sid>hi("TabLine",       s:gui05, s:gui01, "none", "")
call <sid>hi("TabLineFill",   s:gui05, s:gui01, "none", "")
call <sid>hi("TabLineSel",    s:gui05, s:gui00, "none", "")

" Status Line
call <sid>hi("SuliGitSub",       s:gui0C, s:gui02, "none", "")
call <sid>hi("SuliGit",          s:gui0A, s:gui02, "none", "")
call <sid>hi("SuliGitMod",       s:gui08, s:gui04, "none", "")
call <sid>hi("SuliFileMod",      s:gui08, s:gui02, "none", "")
call <sid>hi("SuliCurDir",       s:gui0C, s:gui02, "none", "")
call <sid>hi("SuliCmd",          s:gui00, s:gui08, "none", "")
call <sid>hi("SuliFTSearch",     s:gui00, s:gui0C, "none", "")
call <sid>hi("SuliPending",      s:gui00, s:gui0A, "none", "")
call <sid>hi("SuliReplace",      s:gui00, s:gui05, "none", "")
call <sid>hi("SuliVisual",       s:gui00, s:gui0E, "none", "")
call <sid>hi("SuliInsert",       s:gui00, s:gui0B, "none", "")
call <sid>hi("SuliNormal",       s:gui00, s:gui03, "none", "")
call <sid>hi("SuliOuter",        s:gui05, s:gui04, "none", "")
call <sid>hi("SuliMid",          s:gui05, s:gui02, "none", "")
call <sid>hi("SuliSep",          s:gui00, s:gui01, "none", "")
call <sid>hi("StatusLineTermNC", s:gui03, s:gui01, "none", "")
call <sid>hi("StatusLineTerm",   s:gui05, s:gui01, "none", "")
call <sid>hi("StatuslineNC",     s:gui03, s:gui01, "none", "")
call <sid>hi("StatusLine",       s:gui05, s:gui01, "none", "")
call <sid>hi("Ruler",            s:gui0A, s:gui0B, "none", "")

" Standard syntax highlighting
call <sid>hi("Boolean",      s:gui09, "", "", "")
call <sid>hi("Character",    s:gui08, "", "", "")
call <sid>hi("Conditional",  s:gui06, "", "", "")
call <sid>hi("Constant",     s:gui09, "", "", "")
call <sid>hi("Define",       s:gui0E, "", "none", "")
call <sid>hi("Delimiter",    s:gui0F, "", "", "")
call <sid>hi("Float",        s:gui09, "", "", "")
call <sid>hi("Function",     s:gui0D, "", "", "")
call <sid>hi("Identifier",   s:gui08, "", "none", "")
call <sid>hi("Include",      s:gui0D, "", "", "")
call <sid>hi("Keyword",      s:gui0E, "", "", "")
call <sid>hi("Label",        s:gui0A, "", "", "")
call <sid>hi("Number",       s:gui09, "", "", "")
call <sid>hi("Operator",     s:gui05, "", "none", "")
call <sid>hi("PreProc",      s:gui0A, "", "", "")
call <sid>hi("Repeat",       s:gui06, "", "", "")
call <sid>hi("Special",      s:gui0C, "", "", "")
call <sid>hi("SpecialChar",  s:gui0F, "", "", "")
call <sid>hi("Statement",    s:gui0E, "", "", "")
call <sid>hi("StorageClass", s:gui0A, "", "", "")
call <sid>hi("String",       s:gui0B, "", "", "")
call <sid>hi("Structure",    s:gui0E, "", "", "")
call <sid>hi("Tag",          s:gui0A, "", "", "")
call <sid>hi("Todo",         s:gui0C, s:gui00, "", "")
call <sid>hi("Type",         s:gui0A, "", "none", "")
call <sid>hi("Typedef",      s:gui0A, "", "", "")

" QuickFix
call <sid>hi("qfError",   s:gui09, s:gui00, "", "")

" C highlighting
call <sid>hi("cOperator",   s:gui0C, "", "", "")
call <sid>hi("cPreCondit",  s:gui0E, "", "", "")

" C++
call <sid>hi("cppStructure",    s:gui0E, "", "", "")

" C# highlighting
call <sid>hi("csClass",                 s:gui0A, "", "", "")
call <sid>hi("csAttribute",             s:gui0A, "", "", "")
call <sid>hi("csModifier",              s:gui0E, "", "", "")
call <sid>hi("csType",                  s:gui08, "", "", "")
call <sid>hi("csUnspecifiedStatement",  s:gui0D, "", "", "")
call <sid>hi("csContextualStatement",   s:gui0E, "", "", "")
call <sid>hi("csNewDecleration",        s:gui08, "", "", "")

" CSS highlighting
call <sid>hi("cssBraces",      s:gui05, "", "", "")
call <sid>hi("cssClassName",   s:gui0E, "", "", "")
call <sid>hi("cssColor",       s:gui0C, "", "", "")

" Diff highlighting
call <sid>hi("DiffAdd",      s:gui0B, s:gui01, "", "")
call <sid>hi("DiffChange",   s:gui03, s:gui01, "", "")
call <sid>hi("DiffDelete",   s:gui08, s:gui01, "", "")
call <sid>hi("DiffText",     s:gui0D, s:gui01, "", "")
call <sid>hi("DiffAdded",    s:gui0B, s:gui01, "", "")
call <sid>hi("DiffFile",     s:gui08, s:gui01, "", "")
call <sid>hi("DiffNewFile",  s:gui0B, s:gui01, "", "")
call <sid>hi("DiffLine",     s:gui0D, s:gui01, "", "")
call <sid>hi("DiffRemoved",  s:gui08, s:gui01, "", "")

" Git highlighting
call <sid>hi("gitcommitOverflow",       s:gui08, "", "", "")
call <sid>hi("gitcommitSummary",        s:gui0B, "", "", "")
call <sid>hi("gitcommitComment",        s:gui03, "", "", "")
call <sid>hi("gitcommitUntracked",      s:gui03, "", "", "")
call <sid>hi("gitcommitDiscarded",      s:gui03, "", "", "")
call <sid>hi("gitcommitSelected",       s:gui03, "", "", "")
call <sid>hi("gitcommitHeader",         s:gui0E, "", "", "")
call <sid>hi("gitcommitSelectedType",   s:gui0D, "", "", "")
call <sid>hi("gitcommitUnmergedType",   s:gui0D, "", "", "")
call <sid>hi("gitcommitDiscardedType",  s:gui0D, "", "", "")
call <sid>hi("gitcommitBranch",         s:gui09, "", "bold", "")
call <sid>hi("gitcommitUntrackedFile",  s:gui0A, "", "", "")
call <sid>hi("gitcommitUnmergedFile",   s:gui08, "", "bold", "")
call <sid>hi("gitcommitDiscardedFile",  s:gui08, "", "bold", "")
call <sid>hi("gitcommitSelectedFile",   s:gui0B, "", "bold", "")

" GitGutter highlighting
call <sid>hi("GitGutterAdd",           s:gui0B, s:gui00, "bold", "")
call <sid>hi("GitGutterChange",        s:gui0C, s:gui00, "bold", "")
call <sid>hi("GitGutterDelete",        s:gui08, s:gui00, "bold", "")
call <sid>hi("GitGutterChangeDelete",  s:gui0E, s:gui00, "bold", "")

" HTML highlighting
call <sid>hi("htmlBold",    s:gui0A, "", "", "")
call <sid>hi("htmlItalic",  s:gui0E, "", "", "")
call <sid>hi("htmlEndTag",  s:gui05, "", "", "")
call <sid>hi("htmlTag",     s:gui05, "", "", "")

" JavaScript highlighting
call <sid>hi("javaScript",          s:gui05, "", "", "")
call <sid>hi("javaScriptBraces",    s:gui05, "", "", "")
call <sid>hi("javaScriptNumber",    s:gui09, "", "", "")
" pangloss/vim-javascript highlighting
call <sid>hi("jsOperator",          s:gui0D, "", "", "")
call <sid>hi("jsStatement",         s:gui0E, "", "", "")
call <sid>hi("jsReturn",            s:gui0E, "", "", "")
call <sid>hi("jsThis",              s:gui08, "", "", "")
call <sid>hi("jsClassDefinition",   s:gui0A, "", "", "")
call <sid>hi("jsFunction",          s:gui0E, "", "", "")
call <sid>hi("jsFuncName",          s:gui0D, "", "", "")
call <sid>hi("jsFuncCall",          s:gui0D, "", "", "")
call <sid>hi("jsClassFuncName",     s:gui0D, "", "", "")
call <sid>hi("jsClassMethodType",   s:gui0E, "", "", "")
call <sid>hi("jsRegexpString",      s:gui0C, "", "", "")
call <sid>hi("jsGlobalObjects",     s:gui0A, "", "", "")
call <sid>hi("jsGlobalNodeObjects", s:gui0A, "", "", "")
call <sid>hi("jsExceptions",        s:gui0A, "", "", "")
call <sid>hi("jsBuiltins",          s:gui0A, "", "", "")

" Mail highlighting
call <sid>hi("mailQuoted1",  s:gui0A, "", "", "")
call <sid>hi("mailQuoted2",  s:gui0B, "", "", "")
call <sid>hi("mailQuoted3",  s:gui0E, "", "", "")
call <sid>hi("mailQuoted4",  s:gui0C, "", "", "")
call <sid>hi("mailQuoted5",  s:gui0D, "", "", "")
call <sid>hi("mailQuoted6",  s:gui0A, "", "", "")
call <sid>hi("mailURL",      s:gui0D, "", "", "")
call <sid>hi("mailEmail",    s:gui0D, "", "", "")

" Markdown highlighting
call <sid>hi("markdownCode",              s:gui0B, "", "", "")
call <sid>hi("markdownError",             s:gui05, s:gui00, "", "")
call <sid>hi("markdownCodeBlock",         s:gui0B, "", "", "")
call <sid>hi("markdownHeadingDelimiter",  s:gui0D, "", "", "")

" NERDTree highlighting
call <sid>hi("NERDTreeDirSlash",  s:gui0D, "", "", "")
call <sid>hi("NERDTreeExecFile",  s:gui05, "", "", "")

" PHP highlighting
call <sid>hi("phpMemberSelector",  s:gui05, "", "", "")
call <sid>hi("phpComparison",      s:gui05, "", "", "")
call <sid>hi("phpParent",          s:gui05, "", "", "")
call <sid>hi("phpMethodsVar",      s:gui0C, "", "", "")

" Python highlighting
call <sid>hi("pythonOperator",  s:gui0E, "", "", "")
call <sid>hi("pythonRepeat",    s:gui0E, "", "", "")
call <sid>hi("pythonInclude",   s:gui0E, "", "", "")
call <sid>hi("pythonStatement", s:gui0E, "", "", "")

" Ruby highlighting
call <sid>hi("rubyAttribute",               s:gui0D, "", "", "")
call <sid>hi("rubyConstant",                s:gui0A, "", "", "")
call <sid>hi("rubyInterpolationDelimiter",  s:gui0F, "", "", "")
call <sid>hi("rubyRegexp",                  s:gui0C, "", "", "")
call <sid>hi("rubySymbol",                  s:gui0B, "", "", "")
call <sid>hi("rubyStringDelimiter",         s:gui0B, "", "", "")

" SASS highlighting
call <sid>hi("sassidChar",     s:gui08, "", "", "")
call <sid>hi("sassClassChar",  s:gui09, "", "", "")
call <sid>hi("sassInclude",    s:gui0E, "", "", "")
call <sid>hi("sassMixing",     s:gui0E, "", "", "")
call <sid>hi("sassMixinName",  s:gui0D, "", "", "")

" Signify highlighting
call <sid>hi("SignifySignAdd",     s:gui0B, s:gui01, "", "")
call <sid>hi("SignifySignChange",  s:gui0D, s:gui01, "", "")
call <sid>hi("SignifySignDelete",  s:gui08, s:gui01, "", "")

" Spelling highlighting
call <sid>hi("SpellBad",   s:gui01, s:gui08, "undercurl", s:gui08)
call <sid>hi("SpellLocal", "", "", "undercurl", s:gui0C)
call <sid>hi("SpellCap",   "", "", "undercurl", s:gui0D)
call <sid>hi("SpellRare",  "", "", "undercurl", s:gui0E)

" Startify highlighting
call <sid>hi("StartifyBracket",  s:gui03, "", "", "")
call <sid>hi("StartifyFile",     s:gui07, "", "", "")
call <sid>hi("StartifyFooter",   s:gui03, "", "", "")
call <sid>hi("StartifyHeader",   s:gui0B, "", "", "")
call <sid>hi("StartifyNumber",   s:gui09, "", "", "")
call <sid>hi("StartifyPath",     s:gui03, "", "", "")
call <sid>hi("StartifySection",  s:gui0E, "", "", "")
call <sid>hi("StartifySelect",   s:gui0C, "", "", "")
call <sid>hi("StartifySlash",    s:gui03, "", "", "")
call <sid>hi("StartifySpecial",  s:gui03, "", "", "")

" Coc highlighting
call <sid>hi("CocHighlightText", "", s:gui01, "", "")

" Java highlighting
call <sid>hi("javaOperator",     s:gui0D, "", "", "")

" Remove functions
delf <sid>hi

" Remove color variables
unlet s:gui00 s:gui01 s:gui02 s:gui03  s:gui04  s:gui05  s:gui06  s:gui07  s:gui08  s:gui09 s:gui0A  s:gui0B  s:gui0C  s:gui0D  s:gui0E  s:gui0F
unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03 s:cterm04 s:cterm05 s:cterm06 s:cterm07 s:cterm08 s:cterm09 s:cterm0A s:cterm0B s:cterm0C s:cterm0D s:cterm0E s:cterm0F
