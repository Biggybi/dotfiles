" =============================================================================
" Filename: autoload/lightline/colorscheme/wombat.vim
" Author: itchyny
" License: MIT License
" Last Change: 2015/11/30 08:37:43.
" =============================================================================
let s:base03 = [ '#242424', 235 ]
let s:base023 = [ '#383a42 ', 236 ]
" let s:base02 = [ '#444444 ', 238 ]
let s:base02 = [ '#c3c3c3 ', 238 ]
let s:base01 = [ '#585858', 240 ]
let s:base00 = [ '#666666', 242  ]
let s:base0 = [ '#808080', 244 ]
let s:base1 = [ '#969696', 247 ]
let s:base2 = [ '#a8a8a8', 248 ]
let s:base3 = [ '#d0d0d0', 252 ]
let s:yellow = [ '#cae682', 180 ]
let s:orange = [ '#e5786d', 173 ]
let s:red = [ '#e5786d', 203 ]
let s:magenta = [ '#f2c68a', 216 ]
" let s:blue = [ '#8ac6f2', 117 ]
let s:blue = [ '#56b6c2', 117 ]
let s:cyan = s:blue
" let s:green = [ '#95e454', 119 ]
let s:green = [ '#98c379', 119 ]
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:base01, s:blue ], [ s:base3, s:base0 ] ]
let s:p.normal.right = [ [ s:base02, s:base0 ], [ s:base3, s:base1 ] ]
let s:p.inactive.right = [ [ s:base02, s:base0 ], [ s:base3, s:base1 ] ]
let s:p.inactive.left =  [ [ s:base02, s:base0 ], [ s:base0, s:base02 ] ]
let s:p.insert.left = [ [ s:base01, s:green ], [ s:base02, s:base0 ] ]
let s:p.replace.left = [ [ s:base01, s:red ], [ s:base02, s:base0 ] ]
let s:p.visual.left = [ [ s:base01, s:magenta ], [ s:base02, s:base0 ] ]
let s:p.normal.middle = [ [ s:base01, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base0, s:base02 ] ]
let s:p.tabline.left = [ [ s:base3, s:base00 ] ]
let s:p.tabline.tabsel = [ [ s:base3, s:base03 ] ]
let s:p.tabline.middle = [ [ s:base2, s:base02 ] ]
let s:p.tabline.right = [ [ s:base2, s:base00 ] ]
let s:p.normal.error = [ [ s:base03, s:red ] ]
let s:p.normal.warning = [ [ s:base023, s:yellow ] ]

let g:lightline#colorscheme#wombat_light#palette = lightline#colorscheme#flatten(s:p)
