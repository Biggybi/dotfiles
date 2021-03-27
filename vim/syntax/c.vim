" Class and Function names
syn match    cCustomParen    "?=(" contains=cParen,cCppParen
syn match    cCustomFunc     "\w\+\s*(\@=" contains=cCustomParen
syn match    cCustomScope    "::"
syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope
hi def link cCustomFunc  Function
hi def link cCustomClass Function

" Custom types
syn match    cCustomType "\<t_\w\+\>"
hi def link cCustomType Type

" Macros
syn match cCustomMacro "\<\(\u\|\d\|_\)\+\>"
hi def link cCustomMacro cOperator

" Structure Delimiter / Member
syn match cStructureDelim  "\(\.\|->\)"
syn match cStructureMember "\(\.\|->\)\w\+" contains=cStructureDelim
hi def link cStructureMember cOperator
hi def link cStructureDelim Structure

" Function pointer argument
syn match cFuncPointerArg "(*\w\+\ze)()"
hi def link cFuncPointerArg Function
