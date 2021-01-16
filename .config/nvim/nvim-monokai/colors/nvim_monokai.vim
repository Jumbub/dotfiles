lua << EOF
--[[ Highlite, a Neovim colorscheme template.
	* Author:     Iron-E (https://github.com/Iron-E)
	* Repository: https://github.com/nvim-highlite

	Initially forked from vim-rnb, a Vim colorsheme template:
	* Author:        Romain Lafourcade (https://github.com/romainl)
	* Canonical URL: https://github.com/romainl/vim-rnb
]]

-- This is the name of your colorscheme which will be used as per |g:colors_name|.
vim.g.colors_name = 'monokai_ts'

--[[ Colors
```lua
	<color name> = { -- Give each color a distinctive name.
		'#<hex color code>', -- Hexadecimal color used in GVim/MacVim or 'NONE'.
		<16-bit color code>, -- Integer 0–255 used by terminals supporting 256 colors or 'NONE'.
		'<ANSI color name>'  -- <cterm-colors>'NONE'
	}
```
]]

local black             = {os.getenv('THEME_BLACK'), 0,   'black'}
local white             = {os.getenv('THEME_WHITE'), 15,  'white'}

local gray_darker       = {os.getenv('THEME_GRAY_DARKER'), 244, 'darkgrey'}
local gray_darke        = {os.getenv('THEME_GRAY_DARK'), 244, 'darkgrey'}
local gray_dark         = {os.getenv('THEME_GRAY'), 236, 'darkgrey'}
local gray              = {os.getenv('THEME_GRAY_LIGHT'), 244, 'gray'}
local gray_light        = {os.getenv('THEME_GRAY_LIGHTER'), 251, 'gray'}

local yellow_dark       = {os.getenv('THEME_YELLOW_DARK'), 180, 'darkyellow'}
local yellow            = {os.getenv('THEME_YELLOW'), 220, 'yellow'}

local red_dark          = {os.getenv('THEME_RED_DARK'), 124, 'darkred'}
local red               = {os.getenv('THEME_RED'), 196, 'red'}
local red_light         = {os.getenv('THEME_RED_LIGHT'), 203, 'red'}

local orange            = {os.getenv('THEME_ORANGE'), 208, 'darkyellow'}
local orange_light      = {os.getenv('THEME_ORANGE_LIGHT'), 214, 'yellow'}

local green_dark        = {os.getenv('THEME_GREEN_DARK'), 83, 'darkgreen'}
local green             = {os.getenv('THEME_GREEN'), 72, 'green'}
local green_light       = {os.getenv('THEME_GREEN_LIGHT'), 72, 'green'}

local blue_dark         = {os.getenv('THEME_BLUE_DARK'), 33, 'darkblue'}
local blue              = {os.getenv('THEME_BLUE'), 63, 'blue'}
local blue_light        = {os.getenv('THEME_BLUE_LIGHT'), 38, 'blue'}

local cyan              = {os.getenv('THEME_CYAN'), 87, 'cyan'}
local cyan_light        = {os.getenv('THEME_CYAN_LIGHT'), 63, 'cyan'}

local pink_dark         = {os.getenv('THEME_PINK_DARK'), 126, 'darkpink'}
local pink              = {os.getenv('THEME_PINK'), 126, 'pink'}
local pink_light        = {os.getenv('THEME_PINK_LIGHT'), 162, 'pink'}

local purple_dark       = {os.getenv('THEME_PURPLE_DARK'), 38,  'darkpink'}
local purple            = {os.getenv('THEME_PURPLE'), 129, 'pink'}
local purple_light      = {os.getenv('THEME_PURPLE_LIGHT'), 63,  'pink'}

--[[ Semantic Translations
```lua
local <semantic name> = <color variable>
```
]]--

local bold = {style='bold'} -- ** bold **
local italicised = {style='italic'} -- _italics_
local underlined = {style='underline'}
local highlighted = {bg=gray_darke}

local text = {fg=white} -- oh no

local comment = {fg=gray_dark} -- // comment

local unimportant = {gray_darker} -- binary

local code = {fg=orange} -- `code`
local constant = {fg=orange} -- CONSTANT
local argument = {fg=orange} -- (arg)

local title = {fg=green, style='bold'} -- # Title
local interpunct = {fg=green} -- * ... - ...
local property = {fg=green} -- asdf=...
local func = {fg=green} -- call(...)

local url = {fg=yellow, style='underline'} -- [...](url)
local string = {fg=yellow} -- "yes"

local warning = {fg=yellow_dark}
local error = {fg=red_dark}

local scalar = {fg=purple} -- false 1234
local urlLabel = {fg=purple} -- [label](...)

local reservedFunc = {fg=blue, style='italic'}
local reservedWord = {fg=blue}

local statement = {fg=red} -- if  while  use  import
local tag = {fg=red} -- <tag>

--[[ highlights
```lua
	<highlight group name 1> = {
		bg?='NONE'|'FG'|'BG'|<color>,
		fg?='NONE'|'FG'|'BG'|<color>,

    -- The |background| variations. (see :h bg)
		dark={fg=<color>},
		light={fg=<color>},

    -- The |highlight-blend| value. (see :h highlight-blend)
		blend=<integer>
    -- The |attr-list| value. (see :h attr-list)
		style=<cterm>|{<cterm> [, <cterm>] [,color=<color>]})
	}

	<highlight group name 2> = '<highlight group name 1>'
```
]]

local BG = 'BG'
local FG = 'FG'
local NONE = 'NONE'

--[[ These are the ones you should edit. ]]
-- This is the only highlight that must be defined separately.
local highlight_group_normal = {bg=black, fg=white}

-- This is where the rest of your highlights should go.
local highlight_groups = {
  -- Made up
  ReservedConstant = reservedWord,
  Property    = property,

	--[[ 4.1. Text Analysis ]]
	Comment     = comment,
	NonText     = unimportant,
	EndOfBuffer = unimportant,
	Whitespace  = unimportant,

	--[[ 4.1.1. Literals]]
	Constant  = constant,
	String    = string,
	Character = string,
	Number    = scalar,
	Boolean   = scalar,
	Float     = scalar,

	--[[ 4.1.2. Identifiers]]
	Identifier = text,
	Function   = func,

	--[[ 4.1.3. Syntax]]
	Statement   = statement,
	Conditional = statement,
	Repeat      = statement,
	Label       = statement,
	Operator    = statement,
	Keyword     = statement,
	Exception   = statement,

	--[[ 4.1.4. Metatextual Information]]
	PreProc   = text,
	Include   = statement,
	Define    = statement,
	Macro     = statement,
	PreCondit = statement,

	--[[ 4.1.5. Semantics]]
	Type         = title,
	StorageClass = reservedWord,
	Structure    = reservedWord,
	Typedef      = reservedWord,

	--[[ 4.1.6. Edge Cases]]
	Special        = scalar,
	SpecialFunction= reservedFunc,
	SpecialChar    = scalar,
	SpecialKey     = scalar,
	Tag            = tag,
	Delimiter      = text,
	SpecialComment = comment,
	Debug          = warning,

	--[[ 4.1.7. Help Syntax]]
	Underlined        = underlined,
	Ignore            = comment,
	Error             = error,
	Todo              = warning,
	helpHyperTextJump = underlined,
	helpSpecial       = reservedWord,
	Hint              = warning,
	Info              = warning,
	Warning           = warning,

	--[[ 4.2... Editor UI  ]]
	--[[ 4.2.1. Status Line]]
	StatusLine       = {bg=gray_darker, fg=green_light},
	StatusLineNC     = {bg=gray_darker, fg=gray},
	StatusLineTerm   = 'StatusLine',
	StatusLineTermNC = 'StatusLineNC',

	--[[ 4.2.2. Separators]]
	VertSplit   = {fg=gray_darker},
	TabLine     = {bg=gray_darker, fg=FG},
	TabLineFill = {fg=FG},
	TabLineSel  = {bg=gray_darker, fg=FG, style='inverse'},
	Title       = {style='bold'},

	--[[ 4.2.3. Conditional Line Highlighting]]
	--Conceal={}
	CursorLine      = {bg=gray_darker},
	CursorLineNr    = {fg=pink_light},
	debugBreakpoint = 'ErrorMsg',
	debugPC         = 'ColorColumn',
	LineNr          = {fg=gray},
	QuickFixLine    = {bg=gray_darker},
	Visual          = highlighted,
	VisualNOS       = {bg=gray_darker},

	--[[ 4.2.4. Popup Menu]]
	Pmenu      = {bg=gray_darker, fg=FG},
	PmenuSbar  = {bg=gray_darker},
	PmenuSel   = {fg=FG},
	PmenuThumb = {bg=white},
	WildMenu   = {},

	--[[ 4.2.5. Folds]]
	FoldColumn = {bg=gray_darker,             style='bold'},
	Folded     = {bg=purple_light,  fg=black, style='italic'},

	--[[ 4.2.6. Diffs]]
	DiffAdd    = {fg=green_dark, style='inverse'},
	DiffChange = {fg=yellow,     style='inverse'},
	DiffDelete = {fg=red,        style='inverse'},
	DiffText   = highlighted,

	--[[ 4.2.7. Searching]]
	IncSearch  = highlighted,
	Search     = highlighted,
	MatchParen = highlighted,

	--[[ 4.2.8. Spelling]]
	SpellBad   = {style={'undercurl', color=red}},
	SpellCap   = {style={'undercurl', color=yellow}},
	SpellLocal = {style={'undercurl', color=green}},
	SpellRare  = {style={'undercurl', color=orange}},

	--[[ 4.2.9. Conditional Column Highlighting]]
	ColorColumn = {style='inverse'},
	SignColumn  = {},

	--[[ 4.2.10. Messages]]
	ErrorMsg   = {fg=red,          style='bold'},
	HintMsg    = {fg=pink,      style='bold'},
	InfoMsg    = {fg=pink_light_light,   style='bold'},
	ModeMsg    = {fg=yellow},
	WarningMsg = {fg=orange,       style='bold'},
	Question   = {fg=orange_light, style='underline'},

	--[[ 4.2.11. LSP ]]
	LspDiagnosticsError = 'Error',
	LspDiagnosticsErrorFloating = 'ErrorMsg',
	LspDiagnosticsErrorSign = 'ErrorMsg',

	LspDiagnosticsWarning = 'Warning',
	LspDiagnosticsWarningFloating = 'WarningMsg',
	LspDiagnosticsWarningSign = 'WarningMsg',

	LspDiagnosticsHint = 'Hint',
	LspDiagnosticsHintFloating = 'HintMsg',
	LspDiagnosticsHintSign = 'HintMsg',

	LspDiagnosticsInformation = 'Info',
	LspDiagnosticsInformationFloating = 'InfoMsg',
	LspDiagnosticsInformationSign = 'InfoMsg',

	LspDiagnosticsUnderline = {style={'underline', color=white}},
	LspDiagnosticsUnderlineError = 'CocErrorHighlight',
	LspDiagnosticsUnderlineHint  = 'CocHintHighlight',
	LspDiagnosticsUnderlineInfo  = 'CocInfoHighlight',
	LspDiagnosticsUnderlineWarning = 'CocWarningHighlight',

	--[[ 4.2.12. Cursor ]]
	Cursor   = {style='inverse'},
	CursorIM = 'Cursor',
	CursorColumn = {bg=gray_dark},

	--[[ 4.2.13. Misc ]]
	Directory = {fg=cyan_light, style='bold'},

	--[[ 4.3. Programming Languages
		Everything in this section is OPTIONAL. Feel free to remove everything
		here if you don't want to define it, or add more if there's something
		missing.
	]]
	--[[ 4.3.1. C ]]
	cConstant    = 'Constant',
	cCustomClass = 'Type',

	--[[ 4.3.2. C++ ]]
	cppSTLexception = 'Exception',
	cppSTLnamespace = 'String',

	--[[ 4.3.3 C# ]]
	csBraces     = 'Delimiter',
	csClass      = 'Structure',
	csClassType  = 'Type',
	csContextualStatement = 'Conditional',
	csEndColon   = 'Delimiter',
	csGeneric    = 'Typedef',
	csInterpolation = 'Include',
	csInterpolationDelimiter = 'SpecialChar',
	csLogicSymbols  = 'Operator',
	csModifier   = 'Keyword',
	csNew        = 'Operator',
	csNewType    = 'Type',
	csParens     = 'Delimiter',
	csPreCondit  = 'PreProc',
	csRepeat     = 'Repeat',
	csStorage    = 'StorageClass',
	csUnspecifiedStatement = 'Statement',
	csXmlTag     = 'Define',
	csXmlTagName = 'Define',

	--[[ 4.3.4. CSS ]]
	cssBraces     = 'Delimiter',
	cssProp       = 'Keyword',
	cssSelectorOp = 'Operator',
	cssTagName    = 'htmlTagName',
	cssUnitDecorators = 'Operator',
	scssAmpersand = 'Special',
	scssAttribute = 'Label',
	scssBoolean   = 'Boolean',
	scssClassChar = {fg=green},
	scssClass     = {fg=green},
	scssDefault   = 'Keyword',
	scssElse      = 'PreCondit',
	scssIf        = 'PreCondit',
	scssInclude   = 'Include',
	scssSelectorChar = 'Operator',
	scssSelectorName = 'Identifier',
	scssVariable  = {fg=white},
	scssVariableAssignment = 'Operator',
	scssMixinName = {fg=green},
	scssMixing = 'Operator',

	sassAmpersand = 'scssAmpersand',
	sassAttribute = 'scssAttribute',
	sassBoolean   = 'scssBoolean',
	sassClassChar = 'scssClassChar',
	sassClass     = 'scssClass',
	sassDefault   = 'scssDefault',
	sassElse      = 'scssElse',
	sassIf        = 'scssIf',
	sassInclude   = 'scssInclude',
	sassSelectorChar = 'scssSelectorChar',
	sassSelectorName = 'scssSelectorName',
	sassVariable  = 'scssVariable',
	sassVariableAssignment = 'scssVariableAssignment',
	sassMixing = 'scssMixing',
	sassMixinName = 'scssMixinName',

	--[[ 4.3.5. Dart ]]
	dartLibrary = 'Statement',

	--[[ 4.3.6. dot ]]
	dotKeyChar = 'Character',
	dotType    = 'Type',

	--[[ 4.3.7. Go ]]
	goBlock                 = 'Delimiter',
	goBoolean               = 'Boolean',
	goBuiltins              = 'Operator',
	goField                 = 'Identifier',
	goFloat                 = 'Float',
	goFormatSpecifier       = 'Character',
	goFunction              = 'Function',
	goFunctionCall          = 'goFunction',
	goFunctionReturn        = {},
	goMethodCall            = 'goFunctionCall',
	goParamType             = 'goReceiverType',
	goPointerOperator       = 'SpecialChar',
	goPredefinedIdentifiers = 'Constant',
	goReceiver              = 'goBlock',
	goReceiverType          = 'goTypeName',
	goSimpleParams          = 'goBlock',
	goType                  = 'Type',
	goTypeConstructor       = 'goFunction',
	goTypeName              = 'Type',
	goVarAssign             = 'Identifier',
	goVarDefs               = 'goVarAssign',

	--[[ 4.3.8. HTML ]]
	htmlArg     = 'Property',
	htmlBold    = bold,
	htmlTitle   = title,
	htmlEndTag  = 'htmlTag',
	htmlH1      = 'markdownH1',
	htmlH2      = 'markdownH2',
	htmlH3      = 'markdownH3',
	htmlH4      = 'markdownH4',
	htmlH5      = 'markdownH5',
	htmlH6      = 'markdownH6',
	htmlItalic  = {style='italic'},
	htmlSpecialTagName = 'Keyword',
	htmlTag     = NONE,
	htmlTagN    = tag,
	htmlTagName = tag,

	--[[ 4.3.9. Java ]]
	javaClassDecl = 'Structure',

	--[[ 4.3.10. JavaScript ]]
	jsFuncBlock   = 'Function',
  jsGlobalNodeObjects = 'Keyword',
	jsArrowFunction = 'Text',
	jsObjectKey   = 'Type',
	jsReturn      = 'Keyword',
	jsVariableDef = 'Identifier',
	jsFuncArgs = argument,
	jsGlobalObjects = 'Type',

	--[[ 4.3.11. JSON ]]
	jsonBraces = 'luaBraces',
	jsonKeywordMatch = 'Operator',
	jsonNull   = 'Constant',
	jsonQuote  = 'Delimiter',
	jsonString = 'String',
	jsonStringSQError = 'Exception',

	--[[ 4.3.12. Lua ]]
	luaBraces       = 'Structure',
	luaBrackets     = 'Delimiter',
	luaBuiltin      = 'Keyword',
	luaComma        = 'Delimiter',
	luaFuncArgName  = 'Identifier',
	luaFuncCall     = 'Function',
	luaFuncId       = 'luaNoise',
	luaFuncKeyword  = 'Type',
	luaFuncName     = 'Function',
	luaFuncParens   = 'Delimiter',
	luaFuncTable    = 'Structure',
	luaLocal        = 'Type',
	luaNoise        = 'Operator',
	luaParens       = 'Delimiter',
	luaSpecialTable = 'StorageClass',
	luaSpecialValue = 'Function',

	--[[ 4.3.12. Make ]]
	makeCommands   = 'Statment',
	makeSpecTarget = 'Type',

	--[[ 4.3.13. Markdown ]]
  markdownH1          = title,
  markdownH1Delimiter = title,
  markdownH2          = title,
  markdownH2Delimiter = title,
  markdownH3          = title,
  markdownH3Delimiter = title,
  markdownH4          = title,
  markdownH4Delimiter = title,
  markdownH5          = title,
  markdownH5Delimiter = title,
  markdownH6          = title,
  markdownH6Delimiter = title,
  markdownCode        = code,
  markdownCodeDelimiter = code,
  markdownLinkText    = urlLabel,
  mkdLink             = urlLabel,
  mkdInlineURL        = underline,
  mkdListItemLine     = underline,
  mkdUrl              = url,
  mkdCode             = code,
  mkdCodeStart        = code,
  mkdCodeEnd          = code,
  mkdCodeDelimiter    = code,
  markdownUrl         = url,
  markdownListMarker  = interpunct,
	mkdBold             = bold,
	mkdHeading          = title,
	mkdItalic           = bold,
	mkdListItem         = interpunct,
	mkdRule             = underlined,
	texMathMatcher      = scalar,
	texMathZoneX        = scalar,
	texMathZoneY        = scalar,

	--[[ 4.3.20. Python ]]
	pythonBrackets        = 'Delimiter',
	pythonBuiltinFunc     = 'Operator',
	pythonBuiltinObj      = 'Type',
	pythonBuiltinType     = 'Type',
	pythonClass           = 'Structure',
	pythonClassParameters = 'pythonParameters',
	pythonDecorator       = 'PreProc',
	pythonDottedName      = 'Identifier',
	pythonError           = 'Error',
	pythonException       = 'Exception',
	pythonInclude         = 'Include',
	pythonIndentError     = 'pythonError',
	pythonLambdaExpr      = 'pythonOperator',
	pythonOperator        = 'Operator',
	pythonParam           = 'Identifier',
	pythonParameters      = 'Delimiter',
	pythonSelf            = 'Statement',
	pythonSpaceError      = 'pythonError',
	pythonStatement       = 'Statement',

	--[[ 4.3.21. Ruby ]]
	rubyClass                  = 'Structure',
	rubyDefine                 = 'Define',
	rubyInterpolationDelimiter = 'Delimiter',

	--[[ 4.3.22. Rust ]]
	rustKeyword   = 'Keyword',
	rustModPath   = 'Include',
	rustScopeDecl = 'Delimiter',
	rustTrait     = 'StorageClass',

	--[[ 4.3.23. Scala ]]
	scalaKeyword        = 'Keyword',
	scalaNameDefinition = 'Identifier',

	--[[ 4.3.24. shell ]]
	shDerefSimple = 'SpecialChar',
	shFunctionKey = 'Function',
	shLoop    = 'Repeat',
	shParen   = 'Delimiter',
	shQuote   = 'Delimiter',
	shSet     = 'Statement',
	shTestOpr = 'Debug',
	shOperator = text,
	shStatement = text,
	shOption = text,

	--[[ 4.3.25. Solidity ]]
	solBuiltinType  = 'Type',
	solContract     = 'Typedef',
	solContractName = 'Function',

	--[[ 4.3.26. TOML ]]
	tomlComment = 'Comment',
	tomlKey     = 'Label',
	tomlTable   = 'StorageClass',

	--[[ 4.3.27. VimScript ]]
	helpSpecial    = 'Special',
	vimFgBgAttrib  = 'Constant',
	vimHiCterm     = 'Label',
	vimHiCtermFgBg = 'vimHiCterm',
	vimHiGroup     = 'Typedef',
	vimHiGui       = 'vimHiCterm',
	vimHiGuiFgBg   = 'vimHiGui',
	vimHiKeyList   = 'Operator',
	vimOption      = 'Define',
	vimSetEqual    = 'Operator',

	--[[ 4.3.28. XML ]]
	xmlAttrib  = property,
	xmlTag     = 'htmlTag',
	xmlEndTag  = 'xmlTagName',
	xmlTagName = 'htmlTagName',
	xmlProcessingDelim = comment,

	--[[ 4.3.29. SQL ]]
	sqlKeyword   = 'Keyword',
	sqlParen     = 'Delimiter',
	sqlSpecial   = 'Constant',
	sqlStatement = 'Statement',
	sqlParenFunc = 'Function',

	--[[ 4.3.30. dos INI ]]
	dosiniHeader = text,
	dosiniLabel = tag,

	--[[ 4.3.31. Crontab ]]
	crontabDay  = 'StorageClass',
	crontabDow  = 'String',
	crontabHr   = 'Number',
	crontabMin  = 'Float',
	crontabMnth = 'Structure',

	--[[ 4.3.32. PlantUML ]]
	plantumlColonLine = {},

	--[[ 4.4. Plugins
		Everything in this section is OPTIONAL. Feel free to remove everything
		here if you don't want to define it, or add more if there's something
		missing.
	]]
	--[[ 4.4.1. ALE ]]
	ALEErrorSign   = 'ErrorMsg',
	ALEWarningSign = 'WarningMsg',

	--[[ 4.4.2. coc.nvim ]]
	CocErrorHighlight   = {style={'underline', color='red'}},
	CocHintHighlight    = {style={'underline', color='pink'}},
	CocInfoHighlight    = {style={'underline', color='pink_light_light'}},
	CocWarningHighlight = {style={'underline', color='orange'}},
	CocErrorSign   = 'ALEErrorSign',
	CocHintSign    = 'HintMsg',
	CocInfoSign    = 'InfoMsg',
	CocWarningSign = 'ALEWarningSign',

	--[[ 4.4.2. vim-jumpmotion / vim-easymotion ]]
	EasyMotion = 'IncSearch',
	JumpMotion = 'EasyMotion',

	--[[ 4.4.4. vim-gitgutter / vim-signify ]]
	GitGutterAdd          = {fg=green},
	GitGutterChange       = {fg=yellow},
	GitGutterDelete       = {fg=red},
	GitGutterChangeDelete = {fg=orange},

	SignifySignAdd    = 'GitGutterAdd',
	SignifySignChange = 'GitGutterChange',
	SignifySignDelete = 'GitGutterDelete',
	SignifySignChangeDelete = 'GitGutterChangeDelete',

	--[[ 4.4.5. vim-indent-guides ]]
	IndentGuidesOdd  = {bg=gray_darker},
	IndentGuidesEven = {bg=gray_dark},

	--[[ 4.4.7. NERDTree ]]
	NERDTreeCWD = 'Label',
	NERDTreeUp  = 'Operator',
	NERDTreeDir = 'Directory',
	NERDTreeDirSlash = 'Delimiter',
	NERDTreeOpenable = 'NERDTreeDir',
	NERDTreeClosable = 'NERDTreeOpenable',
	NERDTreeExecFile = 'Function',
	NERDTreeLinkTarget = 'Tag',

	--[[ 4.4.8. nvim-treesitter ]]
	TSVariable  = 'Identifier',
	TSParameter = 'Parameter',
  TSInclude = 'Include',
	TSTypeBuiltin = 'Keyword',
	TSVariableBuiltin = 'ReservedVariable',
	TSType = 'Type',
	TSMethod = 'Method',
	TSKeyword = 'Keyword',
	TSFunction = 'Function',
  TSProperty = 'Property',
  TSNumber = 'Number',
  TSBoolean = 'Boolean',
	TSConstBuiltin = 'ReservedConstant',
	TSConstructor  = 'Typedef',
	TSOperator  = 'Operator',
	TSTagDelimiter  = 'Text',
	TSFuncBuiltin  = 'Function',
	TSStringEscape = 'Character',
	TSStringRegex  = 'SpecialChar',
	TSURI = 'Url',
  TSLabel = 'Label',
  TSTag = 'Tag',

  --[[ yml ]]
  yamlBool = 'Boolean',
  yamlBlockMappingKey = 'Tag',
  yamlFlowIndicator = 'Text',
  yamlPlainScalar = 'String',
  yamlBlockCollectionItemStart = 'Text',
  yamlKeyValueDelimiter = 'Text',

  --[[ typescript ]]
  typescriptObjectLabel = {fg=orange},

  --[[ tsx ]]
  tsxAttrib = {fg=green}
}

local terminal_ansi_colors = {
	[1]  = black,
	[2]  = red_dark,
	[3]  = green_dark,
	[4]  = orange,
	[5]  = blue,
	[6]  = pink_dark,
	[7]  = blue_light,
	[8]  = gray,
	[9]  = gray_dark,
	[10] = red,
	[11] = green,
	[12] = yellow,
	[13] = blue_dark,
	[14] = purple,
	[15] = cyan,
	[16] = gray_light
}

-- Change 'highlite' to the name of your colorscheme as defined in step 1.
require('monokai_ts')(
	highlight_group_normal,
	highlight_groups,
	terminal_ansi_colors
)

-- Thanks to Romain Lafourcade (https://github.com/romainl) for the original template (romainl/vim-rnb).
-- vim: ft=lua

EOF
