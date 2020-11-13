" Vim syntax file
" Language:     Tomb
" Maintainer:   merl111 (mathias@bloctec.dev)
" URL:          https://github.com/phantasma/vim-tomb
" Acknowledgement: Based off of vim-solidity


if exists("b:current_syntax")
  finish
endif

syn sync minlines=50

" Common Groups
syn match     tombComma            ','
syn keyword   tombStorageType      contained skipempty skipwhite nextgroup=tombStorageType
      \ public private
syn keyword   tombFuncStorageType  contained
      \ storage calldata memory
syn keyword   tombPayableType  contained
      \ payable

hi def link   tombStorageType      Keyword
hi def link   tombFuncStorageType  Keyword
hi def link   tombPayableType     Keyword

" Common Groups Highlighting
hi def link   tombParens           Normal
hi def link   tombComma            Normal

" Complex Types
syn keyword   tombEnum             nextgroup=tombEnumBody skipwhite skipempty
      \ enum
syn region    tombEnumBody         start='(' end=')' contained contains=tombComma,tombValueType
syn keyword   tombStruct           nextgroup=tombStructBody skipempty skipwhite
      \ struct
syn region    tombStructBody       start='{' end='}' contained contains=tombComma,tombValueType,tombStruct,tombEnum
syn match     tombCustomType       skipempty skipwhite nextgroup=tombStorageType
      \ '\v[a-zA-Z_][a-zA-Z0-9_]*\s*(<public>|<private>>)@='

hi def link   tombEnum             Define
hi def link   tombStruct           Define

" Numbers
syntax match  tombNumber           '\v0x\x+>'
syntax match  tombNumber           '\v\c<%(\d+%(e[+-]=\d+)=|0b[01]+|0o\o+|0x\x+)>'
syntax match tombNumber            '\v\c<%(\d+.\d+|\d+.|.d+)%(e[+-]=\d+)=>'

" Strings
syntax region tombString           start=/\v"/ skip=/\v\\./ end=/\v"/
syntax region tombString           start="\v'" skip="\v\\." end="\v'"

hi def link   tombNumber           Number
hi def link   tombString           String

" Operators
syn match     tombOperator         '\v\!'
syn match     tombOperator         '\v\|'
syn match     tombOperator         '\v\&'
syn match     tombOperator         '\v\%'
syn match     tombOperator         '\v\~'
syn match     tombOperator         '\v\^'
syn match     tombOperator         '\v\*'
syn match     tombOperator         '\v/'
syn match     tombOperator         '\v\+'
syn match     tombOperator         '\v-'
syn match     tombOperator         '\v\?'
syn match     tombOperator         '\v\:'
syn match     tombOperator         '\v\;'
syn match     tombOperator         '\v\>'
syn match     tombOperator         '\v\<'
syn match     tombOperator         '\v\>\='
syn match     tombOperator         '\v\<\='
syn match     tombOperator         '\v\='
syn match     tombOperator         '\v\*\='
syn match     tombOperator         '\v/\='
syn match     tombOperator         '\v\+\='
syn match     tombOperator         '\v-\='

hi def link   tombOperator         Operator

syn keyword   tombModifier         private public
syn keyword   tombTrigger          trigger 
syn keyword   tombNft              nft 
syn keyword   tombProperty         property
" Functions
syn keyword   tombConstructor      nextgroup=tombFuncParam skipwhite skipempty
      \ constructor
syn match     tombFuncName         contained nextgroup=tombFuncParam skipwhite skipempty
      \ '\v<[a-zA-Z_][0-9a-zA-z_]*'
syn region    tombFuncParam
      \ contained
      \ contains=tombComma,tombValueType,tombFuncStorageType
      \ nextgroup=tombFuncModCustom,tombFuncModifier,tombFuncReturn,tombFuncBody
      \ skipempty
      \ skipwhite
      \ start='('
      \ end=')'

syn keyword   tombFuncModifier     contained nextgroup=tombFuncModifier,tombFuncModCustom,tombFuncReturn,tombFuncBody skipwhite skipempty
      \ public private
syn match     tombFuncModCustom    contained nextgroup=tombFuncModifier,tombFuncModCustom,tombFuncReturn,tombFuncBody,tombFuncModParens  skipempty skipwhite
      \ '\v<[a-zA-Z_][0-9a-zA-z_]*'
syn keyword   tombFuncReturn       contained nextgroup=tombFuncRetParens skipwhite skipempty returns
syn region    tombFuncRetParens    contains=tombValueType,tombFuncStorageType nextgroup=tombFuncBody skipempty skipwhite
      \ start='(' 
      \ end=')' 
syn region    tombFuncBody         contained contains=tombDestructure,tombComment,tombAssemblyBlock,tombEmitEvent,tombTypeCast,tombMethod,tombValueType,tombConstant,tombKeyword,tombRepeat,tombLabel,tombException,tombStructure,tombFuncStorageType,tombOperator,tombNumber,tombString,tombFuncCall,tombIf,tombLoop skipempty skipwhite
      \ start='{' 
      \ end='}' 
syn match     tombFuncCall         contained skipempty skipwhite nextgroup=tombFuncCallParens
      \ '\v%(%(<if>|<number>|<bytes>|<address>|<string>|<bool>)\s*)@<!<[a-zA-Z_][0-9a-zA-z_]*\s*%(\((\n|.|\s)*\))@='
syn region    tombFuncCallParens   contained transparent contains=tombString,tombFuncCall,tombConstant,tombNumber,tombMethod,tombTypeCast,tombComma
      \ start='('
      \ end=')'
syn region    tombFuncModParens    contained contains=tombConstant nextgroup=tombFuncReturn,tombFuncModifier,tombFuncModCustom,tombFuncBody skipempty skipwhite transparent
      \ start='('
      \ end=')'

hi def link   tombModifier         StorageClass
hi def link   tombTrigger          StorageClass
hi def link   tombNft              StorageClass
hi def link   tombProperty         Keyword
hi def link   tombConstructor      Define
hi def link   tombFuncName         Function
hi def link   tombFuncModifier     Keyword
hi def link   tombFuncModCustom    Keyword
hi def link   tombFuncCall         Function
hi def link   tombFuncReturn       special

" Modifiers
syn keyword   tombModifier         modifier nextgroup=tombModifiername skipwhite
syn match     tombModifierName     /\<[a-zA-Z_][0-9a-zA-z_]*/ contained nextgroup=tombModifierParam skipwhite
syn region    tombModifierParam    start='(' end=')' contained contains=tombComma,tombValueType,tombFuncStorageType nextgroup=tombModifierBody skipwhite skipempty
syn region    tombModifierBody     start='{' end='}' contained contains=tombDestructure,tombAssemblyBlock,tombEmitEvent,tombTypeCast,tombMethod,tombFuncCall,tombModifierInsert,tombValueType,tombConstant,tombKeyword,tombRepeat,tombLabel,tombException,tombStructure,tombFuncStorageType,tombOperator,tombNumber,tombString,tombFuncCall,tombIf,tombLoop skipempty skipwhite transparent
syn match     tombModifierInsert   /\<_\>/ containedin=tombModifierBody

hi def link   tombModifier         Define
hi def link   tombModifierName     Function
hi def link   tombModifierInsert   Function

" Contracts, Tokens
syn match     tombContract         /\<\%(contract\|token\)\>/ nextgroup=tombContractName skipwhite
syn match     tombContractName     /\<[a-zA-Z_][0-9a-zA-Z_]*/ contained nextgroup=tombContractParent skipwhite
syn region    tombContractParent   start=/\<is\>/ end='{' contained contains=tombContractName,tombComma,tombInheritor
syn match     tombInheritor        /\<is\>/ contained
syn region    tombLibUsing         start=/\<import\>/ end=/\<for\>/ contains=tombLibName
syn match     tombLibName          /[a-zA-Z_][0-9a-zA-Z_]*\s*\zefor/ contained

hi def link   tombContract         Define
hi def link   tombContractName     Function
hi def link   tombInheritor        Keyword
hi def link   tombLibUsing         Special
hi def link   tombLibName          Type

" Events
syn match     tombEvent            /\<event\>/ nextgroup=tombEventName,tombEventParams skipwhite
syn match     tombEventName        /\<[a-zA-Z_][0-9a-zA-Z_]*/ nextgroup=tombEventParam contained skipwhite
syn region    tombEventParam       start='(' end=')' contains=tombComma,tombValueType,tombEventParamMod,other contained skipwhite skipempty
syn match     tombEventParamMod    /\(\<indexed\>\|\<anonymous\>\)/ contained
syn keyword   tombEmitEvent        emit

hi def link   tombEvent            Define
hi def link   tombEventName        Function
hi def link   tombEventParamMod    Keyword
hi def link   tombEmitEvent        Special

" Constants
syn keyword   tombConstant         true false wei szabo finney ether seconds minutes hours days weeks years now super
syn keyword   tombConstant         block msg now tx this abi

hi def link   tombConstant         Constant

" Reserved keywords https://tombidity.readthedocs.io/en/v0.5.7/miscellaneous.html#reserved-keywords
syn keyword   tombReserved         after alias apply auto case catch copyof default
syn keyword   tombReserved         define final implements in inline let macro match
syn keyword   tombReserved         mutable null of partial promise reference relocatable
syn keyword   tombReserved         sealed sizeof static supports switch typedef typeof unchecked

hi def link   tombReserved         Error

" Pragma
syn match     tombPragma           /\<pragma\s*tombidity\>/

hi def link   tombPragma           PreProc

" Assembly
syn keyword   tombAssemblyName     assembly  contained
syn region    tombAssemblyBlock    start=/\<assembly\s*{/ end=/}/ contained contains=tombAssemblyName,tombAssemblyLet,tombAssemblyOperator,tombAssemblyConst,tombAssemblyMethod,tombComment,tombNumber,tombString,tombOperator,tombAssemblyCond,tombAssmNestedBlock
syn match     tombAssemblyOperator /\(:=\)/ contained
syn keyword   tombAssemblyLet      let contained
syn keyword   tombAssemblyMethod   stop add sub mul div sdiv mod smod exp not lt gt slt sgt eq iszero contained
syn keyword   tombAssemblyMethod   and or xor byte shl shr sar addmod mulmod signextend keccak256 jump contained
syn keyword   tombAssemblyMethod   jumpi pop mload mstore mstore8 sload sstore calldataload calldatacopy contained
syn keyword   tombAssemblyMethod   codecopy extcodesize extcodecopy returndatacopy extcodehash create create2 contained
syn keyword   tombAssemblyMethod   call callcode delegatecall staticcall return revert selfdestruct contained
syn keyword   tombAssemblyMethod   log0 log1 log2 log3 log4 blockhash contained
syn match     tombAssemblyMethod   /\<\(swap\|dup\)\d\>/ contained
syn keyword   tombAssemblyConst    pc msize gas address caller callvalue calldatasize codesize contained
syn keyword   tombAssemblyConst    returndatasize origin gasprice coinbase timestamp number difficulty gaslimit contained
syn keyword   tombAssemblyCond     if else contained
syn region    tombAssmNestedBlock  start=/\(assembly\s*\)\@<!{/ end=/}/ contained skipwhite skipempty transparent

hi def link   tombAssemblyBlock    PreProc
hi def link   tombAssemblyName     Special
hi def link   tombAssemblyOperator Operator
hi def link   tombAssemblyLet      Keyword
hi def link   tombAssemblyMethod   Special
hi def link   tombAssemblyConst    Constant
hi def link   tombAssemblyCond     Conditional

" Builtin Methods
syn keyword   tombMethod           delete new var return import
syn region    tombMethodParens     start='(' end=')' contains=tombString,tombConstant,tombNumber,tombFuncCall,tombTypeCast,tombMethod,tombComma contained transparent
syn keyword   tombMethod           nextgroup=tombMethodParens skipwhite skipempty
      \ blockhash require revert assert keccak256 sha256
      \ ripemd160 ecrecover addmod mullmod selfdestruct

hi def link   tombMethod           Special

" Miscellaneous
"syn keyword   tombRepeat           do
"syn keyword   tombLabel            break continue
syn keyword   tombException        throw

hi def link   tombRepeat           Repeat
hi def link   tombLabel            Label
hi def link   tombException        Exception

" Simple Types
syn match     tombValueType        /\<uint\d*\>/ nextgroup=tombStorageType,tombStorageConst skipwhite skipempty
syn match     tombValueType        /\<int\d*\>/ nextgroup=tombStorageType,tombStorageConst skipwhite skipempty
syn match     tombValueType        /\<fixed\d*\>/ nextgroup=tombStorageType,tombStorageConst skipwhite skipempty
syn match     tombValueType        /\<ufixed\d*\>/ nextgroup=tombStorageType,tombStorageConst skipwhite skipempty
syn match     tombValueType        /\<bytes\d*\>/ nextgroup=tombStorageType,tombStorageConst skipwhite skipempty
syn match     tombValueType        /\<address\>/ nextgroup=tombPayableType,tombStorageType,tombStorageConst skipwhite skipempty
syn match     tombValueType        /\<string\>/ nextgroup=tombStorageType,tombStorageConst skipwhite skipempty
syn match     tombValueType        /\<number\>/ nextgroup=tombStorageType,tombStorageConst skipwhite skipempty
syn match     tombValueType        /\<bool\>/ nextgroup=tombStorageType,tombStorageConst skipwhite skipempty

syn match     tombValueType        /\<uint\d*\s*\[\]/ nextgroup=tombStorageType,tombStorageConst skipwhite skipempty
syn match     tombValueType        /\<int\d*\s*\[\]/ nextgroup=tombStorageType,tombStorageConst skipwhite skipempty
syn match     tombValueType        /\<fixed\d*\s*\[\]/ nextgroup=tombStorageType,tombStorageConst skipwhite skipempty
syn match     tombValueType        /\<ufixed\d*\s*\[\]/ nextgroup=tombStorageType,tombStorageConst skipwhite skipempty
syn match     tombValueType        /\<bytes\d*\s*\[\]/ nextgroup=tombStorageType,tombStorageConst skipwhite skipempty
syn match     tombValueType        /\<address\%(\spayable\)\s*\[\]/ contains=tombPayableType nextgroup=tombStorageType,tombStorageConst skipwhite skipempty
syn match     tombValueType        /\<string\s*\[\]/ nextgroup=tombStorageType,tombStorageConst skipwhite skipempty
syn match     tombValueType        /\<number\s*\[\]/ nextgroup=tombStorageType,tombStorageConst skipwhite skipempty
syn match     tombValueType        /bool\s*\[\]/ nextgroup=tombStorageType,tombStorageConst skipwhite skipempty

syn match     tombTypeCast         /\<uint\d*\ze\s*(/ nextgroup=tombTypeCastParens skipwhite skipempty
syn match     tombTypeCast         /\<int\d*\ze\s*(/ nextgroup=tombTypeCastParens skipwhite skipempty
syn match     tombTypeCast         /\<ufixed\d*\ze\s*(/ nextgroup=tombTypeCastParens skipwhite skipempty
syn match     tombTypeCast         /\<bytes\d*\ze\s*(/ nextgroup=tombTypeCastParens skipwhite skipempty
syn match     tombTypeCast         /\<address\ze\s*(/ nextgroup=tombTypeCastParens skipwhite skipempty
syn match     tombTypeCast         /\<string\ze\s*(/ nextgroup=tombTypeCastParens skipwhite skipempty
syn match     tombTypeCast         /\<number\ze\s*(/ nextgroup=tombTypeCastParens skipwhite skipempty
syn match     tombTypeCast         /\<bool\ze\s*(/ nextgroup=tombTypeCastParens skipwhite skipempty
syn region    tombTypeCastParens   start=/(/ end=/)/ contained contains=tombMethod,tombFuncCall,tombString,tombConstant,tombNumber,tombTypeCast,tombComma transparent

hi def link   tombValueType        Type
hi def link   tombTypeCast         Type

" Conditionals
syn match     tombIf               /\<if\>/ contained skipwhite skipempty nextgroup=tombIfParens
syn match     tombElse             /\<else\>/ contained skipwhite skipempty nextgroup=tombIf,tombIfBlock
syn region    tombIfParens         start=/(/ end=/)/ contained nextgroup=tombIfBlock skipwhite skipempty transparent
syn region    tombIfBlock          start=/{/ end=/}/ contained nextgroup=tombElse skipwhite skipempty transparent

hi def link   tombIf               Keyword
hi def link   tombElse             Keyword

" Loops
syn match     tombLoop             /\(\<for\>\|\<while\>\)/ contained skipwhite skipempty nextgroup=tombLoopParens
syn region    tombLoopParens       start=/(/ end=/)/ contained nextgroup=tombLoopBlock skipwhite skipempty transparent
syn region    tombLoopBlock        start=/{/ end=/}/ contained skipwhite skipempty transparent

hi def link   tombLoop             Keyword


" Comments
syn keyword   tombTodo             TODO FIXME XXX TBD contained
syn region    tombComment          start=/\/\// end=/$/ contains=tombTodo
syn region    tombComment          start=/\/\*/ end=/\*\// contains=tombTodo

hi def link   tombTodo             Todo
hi def link   tombComment          Comment

" Natspec
syn match     tombNatspecTag       /@dev\>/ contained
syn match     tombNatspecTag       /@title\>/ contained
syn match     tombNatspecTag       /@author\>/ contained
syn match     tombNatspecTag       /@notice\>/ contained
syn match     tombNatspecTag       /@param\>/ contained
syn match     tombNatspecTag       /@return\>/ contained
syn match     tombNatspecParam     /\(@param\s*\)\@<=\<[a-zA-Z_][0-9a-zA-Z_]*/
syn region    tombNatspecBlock     start=/\/\/\// end=/$/ contains=tombTodo,tombNatspecTag,tombNatspecParam
syn region    tombNatspecBlock     start=/\/\*\{2}/ end=/\*\// contains=tombTodo,tombNatspecTag,tombNatspecParam

hi def link   tombNatspecTag       SpecialComment
hi def link   tombNatspecBlock     Comment
hi def link   tombNatspecParam     Define
