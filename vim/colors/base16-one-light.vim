" vi:syntax=vim

" base16-vim (https://github.com/chriskempson/base16-vim)
" by Chris Kempson (http://chriskempson.com)
" One Light scheme by Daniel Pfeifer (http://github.com/purpleKarrot)

" This enables the coresponding base16-shell script to run so that
" :colorscheme works in terminals supported by base16-shell scripts
" User must set this variable in .vimrc
"   let g:base16_shell_path=base16-builder/output/shell/
let s:colors_name = "base16-one-light"
let g:base16_one_light_shell = get(g:, 'base16_one_light_shell',
			\'$BASE16_PATH/' .. s:colors_name)
let g:base16_noshell = get(g:, 'base16_noshell', 0)

if !has("gui_running") && g:base16_noshell != 1 && v:vim_did_enter == 1
    execute "silent !source" g:base16_one_light_shell
endif

" GUI color definitions
let s:gui00     = "#ffffff"
let s:gui01     = "#C3C3C3"
let s:gui02     = "#e5e5e5"
let s:gui03     = "#a0a1a7"
let s:gui04     = "#696c77"
let s:gui05     = "#383a42"
let s:gui06     = "#d675d6"
let s:gui07     = "#090a0b"
let s:gui08     = "#c96169"
let s:gui09     = "#f88f22"
let s:gui0A     = "#d37400"
let s:gui0B     = "#489047"
let s:gui0C     = "#3696c2"
let s:gui0D     = "#396cd9"
let s:gui0E     = "#9364be"
let s:gui0F     = "#986801"

" Terminal color definitions
let s:cterm00   = "00"
let s:cterm03   = "08"
let s:cterm05   = "07"
let s:cterm07   = "15"
let s:cterm08   = "01"
let s:cterm0A   = "03"
let s:cterm0B   = "02"
let s:cterm0C   = "06"
let s:cterm0D   = "04"
let s:cterm0E   = "05"
if exists("base16colorspace") && base16colorspace == "256"
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
        \ "#ffffff",
        \ "#C3C3C3",
        \ "#489047",
        \ "#a0a1a7",
        \ "#696c77",
        \ "#383a42",
        \ "#3696c2",
        \ "#090a0b",
        \ "#c3c3c3",
        \ "#f88f22",
        \ "#489047",
        \ "#d37400",
        \ "#3696c2",
        \ "#9364be",
        \ "#9364be",
        \ "#986801",
        \ ]
endif

if has("nvim")
  function! s:Nvim_term_colors() abort
    let i = 0
    for term_color in g:terminal_ansi_colors
      exe printf("let g:terminal_color_%d = \"%s\"", i, term_color)
      let i = i + 1
    endfor
      let g:terminal_color_background = g:terminal_color_7
      let g:terminal_color_foreground = g:terminal_color_2
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
  call <sid>hi("Normal",        "05", "00", "", "")
  call <sid>hi("Bold",          "", "", "bold", "")
  call <sid>hi("Debug",         "08", "", "", "")
  call <sid>hi("Directory",     "0D", "", "", "")
  call <sid>hi("Error",         "07", "08", "", "")
  call <sid>hi("ErrorMsg",      "08", "00", "", "")
  call <sid>hi("TrailSpace",    "0C", "01", "strikethrough", "")
  call <sid>hi("Exception",     "08", "", "", "")
  call <sid>hi("FoldColumn",    "0C", "01", "", "")
  " call <sid>hi("Folded",        "03", "01", "", "")
  call <sid>hi("Folded",        "03", "00", "", "")
  call <sid>hi("CocHighlightText", "", "02", "", "")
  " call <sid>hi("IncSearch",     "0E", "01", "none", "")
  " call <sid>hi("EdgeSearch",     "08", "01", "none", "")
  " call <sid>hi("Search",        "0D", "01",  "", "")
  call <sid>hi("Search",        "02", "0A",  "", "")
  call <sid>hi("IncSearch",     "02", "0B", "none", "")
  call <sid>hi("FirstSearch",    "02", "0D", "none", "")
  call <sid>hi("LastSearch",    "02", "08", "none", "")
  " call <sid>hi("IncSearch",     "00", "0B", "none", "")
  " call <sid>hi("EdgeSearch",     "00", "09", "none", "")
  " call <sid>hi("Search",        "00", "0C",  "", "")
  call <sid>hi("Italic",        "", "", "none", "")
  call <sid>hi("Macro",         "08", "", "", "")
  " call <sid>hi("MatchParen",    "03", "00",  "underline", "")
  call <sid>hi("MatchParen",    "0C", "02",  "", "")
  call <sid>hi("ModeMsg",       "0B", "", "", "")
  call <sid>hi("MoreMsg",       "0B", "", "", "")
  call <sid>hi("Question",      "0D", "", "", "")
  call <sid>hi("Substitute",    "01", "0B", "none", "")
  " call <sid>hi("SpecialKey",    "04", "0D", "", "")
  call <sid>hi("SpecialKey",    "04", "", "", "")
  call <sid>hi("TooLong",       "08", "", "", "")
  call <sid>hi("Underlined",    "08", "", "", "")
  " call <sid>hi("Visual",        "", "02", "", "")
  call <sid>hi("Visual",        "", "02", "", "")
  call <sid>hi("VisualNOS",     "08", "", "", "")
  call <sid>hi("WarningMsg",    "08", "", "", "")
  " call <sid>hi("WildMenu",      "08", "0A", "", "")
  " call <sid>hi("WildMenu",      "08", "01", "", "")
  call <sid>hi("WildMenu",      "01", "04", "", "")
  call <sid>hi("Title",         "0D", "", "none", "")
  call <sid>hi("Conceal",       "03", "01", "", "")
  call <sid>hi("Ignore",       "03", "00", "", "")
  call <sid>hi("Cursor",        "00", "05", "", "")
  call <sid>hi("NonText",       "03", "", "", "")
  " call <sid>hi("LineNr",        "03", "01", "", "")
  call <sid>hi("LineNr",        "03", "00", "", "")
  " call <sid>hi("SignColumn",    "03", "01", "", "")
  call <sid>hi("SignColumn",    "03", "00", "", "")
  " call <sid>hi("VertSplit",     "02", "02", "none", "")
  " call <sid>hi("VertSplit",     "04", "00", "none", "")
  call <sid>hi("VertSplit",     "02", "00", "none", "")
  call <sid>hi("VertSplit2",     "02", "01", "none", "")
  call <sid>hi("ColorColumn",   "", "02", "none", "")
  call <sid>hi("CursorColumn",  "", "01", "none", "")
  call <sid>hi("CursorLine",    "", "00", "none", "")
  call <sid>hi("CursorLineNr",  "05", "02", "none", "")
  call <sid>hi("EndOfBuffer",  "00", "00", "none", "")
  call <sid>hi("QuickFixLine",  "", "02", "none", "")
  call <sid>hi("PMenu",         "05", "01", "none", "")
  call <sid>hi("PMenuSel",      "05", "03", "", "")
  call <sid>hi("PMenuSbar",     "03", "03", "", "")
  call <sid>hi("PMenuThumb",    "02", "01", "", "")
  call <sid>hi("TabLine",       "05", "02", "none", "")
  call <sid>hi("TabLineFill",   "05", "00", "none", "")
  call <sid>hi("TabLineSel",    "05", "03", "none", "")
  " Status Line
  call <sid>hi("SuliGitSub",    "0B", "02", "none", "")
  call <sid>hi("SuliGit",       "0D", "02", "none", "")
  call <sid>hi("SuliCurDir",    "00", "02", "none", "")
  call <sid>hi("SuliGitMod",    "08", "01", "none", "")
  call <sid>hi("SuliFileMod",   "08", "02", "none", "")
  call <sid>hi("SuliFTSearch",  "00", "0C", "none", "")
  call <sid>hi("SuliCmd",       "00", "08", "none", "")
  call <sid>hi("SuliPending",   "00", "0A", "none", "")
  call <sid>hi("SuliReplace",   "00", "09", "none", "")
  call <sid>hi("SuliVisual",    "00", "0E", "none", "")
  " call <sid>hi("SuliVisual",  "00", "08", "none", "")
  call <sid>hi("SuliInsert",    "00", "0B", "none", "")
  call <sid>hi("SuliNormal",    "00", "03", "none", "")
  call <sid>hi("SuliOuter",     "05", "01", "none", "")
  call <sid>hi("SuliMid",       "05", "02", "none", "")
  call <sid>hi("SuliSep",       "00", "01", "none", "")
  call <sid>hi("StatusLineTermNC",    "04", "02", "none", "")
  call <sid>hi("StatusLineTerm",      "05", "02", "none", "")
  call <sid>hi("StatuslineNC",        "04", "02", "none", "")
  call <sid>hi("StatusLine",          "05", "02", "none", "")
  " call <sid>hi("StatusLine",        "04", "02", "none", "")

  " QuickFix
  call <sid>hi("qfError",   "09", "00", "", "")

  " Standard syntax highlighting
  call <sid>hi("Boolean",      "09", "", "", "")
  call <sid>hi("Character",    "08", "", "", "")
  " call <sid>hi("Comment",      "03", "", "italic", "")
  call <sid>hi("Comment",      "03", "00", "italic", "")
  " call <sid>hi("Conditional",  "0E", "", "", "")
  call <sid>hi("Conditional",  "06", "", "", "")
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
  call <sid>hi("Operator",     "05", "", "none", "")
  call <sid>hi("PreProc",      "0A", "", "", "")
  call <sid>hi("Repeat",       "0E", "", "", "")
  call <sid>hi("Special",      "0C", "", "", "")
  call <sid>hi("SpecialChar",  "0F", "", "", "")
  call <sid>hi("Statement",    "0E", "", "", "")
  call <sid>hi("StorageClass", "0A", "", "", "")
  call <sid>hi("String",       "0B", "", "", "")
  call <sid>hi("Structure",    "0E", "", "", "")
  call <sid>hi("Tag",          "0A", "", "", "")
  call <sid>hi("Todo",         "0C", "00", "", "")
  call <sid>hi("Type",         "0A", "", "none", "")
  call <sid>hi("Typedef",      "0A", "", "", "")

  " C highlighting
  call <sid>hi("cOperator",   "0C", "", "", "")
  call <sid>hi("cPreCondit",  "0E", "", "", "")

  " C# highlighting
  call <sid>hi("csClass",                 "0A", "", "", "")
  call <sid>hi("csAttribute",             "0A", "", "", "")
  call <sid>hi("csModifier",              "0E", "", "", "")
  call <sid>hi("csType",                  "08", "", "", "")
  call <sid>hi("csUnspecifiedStatement",  "0D", "", "", "")
  call <sid>hi("csContextualStatement",   "0E", "", "", "")
  call <sid>hi("csNewDecleration",        "08", "", "", "")

  " CSS highlighting
  call <sid>hi("cssBraces",      "05", "", "", "")
  call <sid>hi("cssClassName",   "0E", "", "", "")
  call <sid>hi("cssColor",       "0C", "", "", "")

  " Diff highlighting
  call <sid>hi("DiffAdd",      "0B", "01", "", "")
  call <sid>hi("DiffChange",   "03", "01", "", "")
  call <sid>hi("DiffDelete",   "08", "01", "", "")
  call <sid>hi("DiffText",     "0D", "01", "", "")
  call <sid>hi("DiffAdded",    "0B", "01", "", "")
  call <sid>hi("DiffFile",     "08", "01", "", "")
  call <sid>hi("DiffNewFile",  "0B", "01", "", "")
  call <sid>hi("DiffLine",     "0D", "01", "", "")
  call <sid>hi("DiffRemoved",  "08", "01", "", "")

  " Git highlighting
  call <sid>hi("gitcommitOverflow",       "08", "", "", "")
  call <sid>hi("gitcommitSummary",        "0B", "", "", "")
  call <sid>hi("gitcommitComment",        "03", "", "", "")
  call <sid>hi("gitcommitUntracked",      "03", "", "", "")
  call <sid>hi("gitcommitDiscarded",      "03", "", "", "")
  call <sid>hi("gitcommitSelected",       "03", "", "", "")
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
  call <sid>hi("GitGutterAdd",     "0B", "00", "", "")
  call <sid>hi("GitGutterChange",  "0D", "00", "", "")
  call <sid>hi("GitGutterDelete",  "08", "00", "", "")
  call <sid>hi("GitGutterChangeDelete",  "0E", "00", "", "")

  " HTML highlighting
  call <sid>hi("htmlBold",    "0A", "", "", "")
  call <sid>hi("htmlItalic",  "0E", "", "", "")
  call <sid>hi("htmlEndTag",  "05", "", "", "")
  call <sid>hi("htmlTag",     "05", "", "", "")

  " JavaScript highlighting
  call <sid>hi("javaScript",        "05", "", "", "")
  call <sid>hi("javaScriptBraces",  "05", "", "", "")
  call <sid>hi("javaScriptNumber",  "09", "", "", "")
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
  call <sid>hi("markdownError",             "05", "00", "", "")
  call <sid>hi("markdownCodeBlock",         "0B", "", "", "")
  call <sid>hi("markdownHeadingDelimiter",  "0D", "", "", "")

  " NERDTree highlighting
  call <sid>hi("NERDTreeDirSlash",  "0D", "", "", "")
  call <sid>hi("NERDTreeExecFile",  "05", "", "", "")

  " PHP highlighting
  call <sid>hi("phpMemberSelector",  "05", "", "", "")
  call <sid>hi("phpComparison",      "05", "", "", "")
  call <sid>hi("phpParent",          "05", "", "", "")
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
  call <sid>hi("SpellBad",     "00", "08", "undercurl", "08")
  call <sid>hi("SpellLocal",   "", "", "undercurl", "0C")
  call <sid>hi("SpellCap",     "", "", "undercurl", "0D")
  call <sid>hi("SpellRare",    "", "", "undercurl", "0E")

  " Startify highlighting
  call <sid>hi("StartifyBracket",  "03", "", "", "")
  call <sid>hi("StartifyFile",     "07", "", "", "")
  call <sid>hi("StartifyFooter",   "03", "", "", "")
  call <sid>hi("StartifyHeader",   "0B", "", "", "")
  call <sid>hi("StartifyNumber",   "09", "", "", "")
  call <sid>hi("StartifyPath",     "03", "", "", "")
  call <sid>hi("StartifySection",  "0E", "", "", "")
  call <sid>hi("StartifySelect",   "0C", "", "", "")
  call <sid>hi("StartifySlash",    "03", "", "", "")
  call <sid>hi("StartifySpecial",  "03", "", "", "")

  " Java highlighting
  call <sid>hi("javaOperator",     "0D", "", "", "")

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

augroup OneLightHL
  au!
  au ColorScheme <amatch> call s:hl()
augroup end


" Remove functions
delf <sid>hi

" Remove color variables
unlet s:gui00 s:gui01 s:gui02 s:gui03  s:gui04  s:gui05  s:gui06  s:gui07  s:gui08  s:gui09 s:gui0A  s:gui0B  s:gui0C  s:gui0D  s:gui0E  s:gui0F
unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03 s:cterm04 s:cterm05 s:cterm06 s:cterm07 s:cterm08 s:cterm09 s:cterm0A s:cterm0B s:cterm0C s:cterm0D s:cterm0E s:cterm0F
