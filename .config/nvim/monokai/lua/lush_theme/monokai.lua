local lush = require('lush')
local hsl = lush.hsl

local getColor = function(color)
  return hsl(os.getenv('THEME_' .. color))
end

---@diagnostic disable: undefined-global
local theme = lush(function()
  return {
    ------------------------------------ Colours ------------------------------------

    regular { fg=getColor('WHITE'), bg=getColor('BLACK') },
    irregular { fg=getColor('GRAY'), bg=getColor('BLACK') },
    invert { fg=getColor('BLACK'), bg=getColor('WHITE') },
    offset { fg=getColor('WHITE'), bg=getColor('GRAY_DARKER') },
    grayBg { bg=getColor('GRAY') },
    darkGrayBg { bg=getColor('GRAY_DARK') },
    shadyDarker { fg=getColor('BLACK'), bg=getColor('GRAY_DARKER') },
    shadyDark { fg=getColor('GRAY_DARKER'), bg=getColor('GRAY') },
    shady { fg=getColor('GRAY_DARK'), bg=getColor('GRAY_LIGHT') },
    shadyLight { fg=getColor('GRAY'), bg=getColor('GRAY_LIGHTER') },
    red { fg=getColor('RED') },
    redBg { bg=getColor('RED'), fg=getColor('BLACK') },
    yellow { fg=getColor('YELLOW') },
    yellowBg { bg=getColor('YELLOW'), fg=getColor('BLACK') },
    blue { fg=getColor('BLUE'), gui='italic' },
    blueBg { fg=getColor('BLACK'), bg=getColor('BLUE'), gui='italic' },
    orange { fg=getColor('ORANGE'), gui='italic' },
    orangeBg { bg=getColor('ORANGE'), fg=getColor('BLACK'), gui='italic' },
    green { fg=getColor('GREEN') },
    greenLc { bg=getColor('GRAY_DARKER'), fg=getColor('GREEN') },
    purple { fg=getColor('PURPLE') },
    pink { fg=getColor('PINK') },
    strong { gui='bold' },

    ------------------------------------ Standards ------------------------------------

    ColorColumn  { darkGrayBg }, -- used for the columns set with 'colorcolumn'
    Conceal      { pink }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    CursorColumn { darkGrayBg }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine   { darkGrayBg }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory    { green }, -- directory names (and other special names in listings)
    DiffAdd      { green }, -- diff mode: Added line |diff.txt|
    DiffChange   { yellow }, -- diff mode: Changed line |diff.txt|
    DiffDelete   { red }, -- diff mode: Deleted line |diff.txt|
    DiffText     { yellow }, -- diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer  { irregular }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    TermCursor   { shadyDark }, -- cursor in a focused terminal
    ErrorMsg     { redBg }, -- error messages on the command line
    VertSplit    { shadyDarker }, -- the column separating vertically split windows
    Folded       { shady }, -- line used for closed folds
    FoldColumn   { shady }, -- 'foldcolumn'
    SignColumn   { regular }, -- column where |signs| are displayed
    IncSearch    { darkGrayBg }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Substitute   { yellowBg }, -- |:substitute| replacement text highlighting
    LineNr       { irregular }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr { pink }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen   { grayBg }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg      { strong }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea      { regular }, -- Area for messages and cmdline
    MsgSeparator { shady }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg      { green }, -- |more-prompt|
    NonText      { blue }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal       { regular }, -- normal text
    Comment       { irregular }, -- normal text
    NormalFloat  { offset }, -- Normal text in floating windows.
    Pmenu        { offset }, -- Popup menu: normal item.
    PmenuSel     { shady }, -- Popup menu: selected item.
    PmenuSbar    { shadyDark }, -- Popup menu: scrollbar.
    PmenuThumb   { shadyLight }, -- Popup menu: Thumb of the scrollbar.
    Question     { green }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine { yellowBg }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search       { darkGrayBg }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    SpecialKey   { irregular }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace| SpellBad  Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.  SpellCap  Word that should start with a capital. |spell| Combined with the highlighting used otherwise.  SpellLocal  Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    StatusLine   { greenLc }, -- status line of current window
    StatusLineNC { shadyDarker }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine      { shadyLight }, -- tab pages line, not active tab page label
    TabLineFill  { shadyDark }, -- tab pages line, where there are no labels
    TabLineSel   { irregular }, -- tab pages line, active tab page label
    Title        { pink }, -- titles for output from ":set all", ":autocmd" etc.
    Visual       { darkGrayBg }, -- Visual mode selection
    VisualNOS    { irregular }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg   { red }, -- warning messages
    Whitespace   { blue }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    WildMenu     { yellowBg }, -- current match in 'wildmenu' completion

    ------------------------------------ Non-standards ------------------------------------

    Constant       { regular }, -- (preferred) any constant
    String         { yellow }, --   a string constant: "this is a string"
    Character      { yellow }, --  a character constant: 'c', '\n'
    Number         { purple }, --   a number constant: 234, 0xff
    Boolean        { purple }, --  a boolean constant: TRUE, false
    Float          { purple }, --    a floating point constant: 2.3e10
    Identifier     { green }, -- (preferred) any variable name
    Function       { green }, -- function name (also: methods for classes)
    Statement      { red }, -- (preferred) any statement
    Conditional    { red }, --  if, then, else, endif, switch, etc.
    -- Repeat         { }, --   for, do, while, etc.
    -- Label          { }, --    case, default, etc.
    -- Operator       { }, -- "sizeof", "+", "*", etc.
    -- Keyword        { }, --  any other keyword
    -- Exception      { }, --  try, catch, throw
    PreProc        { red }, -- (preferred) generic Preprocessor
    -- Include        { }, --  preprocessor #include
    -- Define         { }, --   preprocessor #define
    -- Macro          { }, --    same as Define
    -- PreCondit      { }, --  preprocessor #if, #else, #endif, etc.
    Type           { blue }, -- (preferred) int, long, char, etc.
    -- StorageClass   { }, -- static, register, volatile, etc.
    -- Structure      { }, --  struct, union, enum, etc.
    -- Typedef        { }, --  A typedef
    Special        { red }, -- (preferred) any special symbol
    -- SpecialChar    { }, --  special character in a constant
    -- Tag            { }, --    you can use CTRL-] on this
    -- Delimiter      { }, --  character that needs attention
    -- SpecialComment { }, -- special things inside a comment
    -- Debug          { }, --    debugging statements
    Underlined { gui = "underline" }, -- (preferred) text that stands out, HTML links
    Bold       { gui = "bold" },
    Italic     { gui = "italic" },
    Error          { redBg }, -- (preferred) any erroneous construct
    Todo           { yellowBg }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
    -- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|

    ------------------------------------ LSP ------------------------------------

    LspReferenceText                     { CursorLine }, -- used for highlighting "text" references
    LspReferenceRead                     { LspReferenceText }, -- used for highlighting "read" references
    LspReferenceWrite                    { LspReferenceText}, -- used for highlighting "write" references

    LspDiagnosticsDefaultError           { red }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    LspDiagnosticsDefaultWarning         { orange }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    LspDiagnosticsDefaultInformation     { yellow }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    LspDiagnosticsDefaultHint            { blue }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)

    -- LspDiagnosticsVirtualTextError       { }, -- Used for "Error" diagnostic virtual text
    -- LspDiagnosticsVirtualTextWarning     { }, -- Used for "Warning" diagnostic virtual text
    -- LspDiagnosticsVirtualTextInformation { }, -- Used for "Information" diagnostic virtual text
    -- LspDiagnosticsVirtualTextHint        { }, -- Used for "Hint" diagnostic virtual text

    LspDiagnosticsUnderlineError         { sp=getColor('RED'), gui="undercurl" }, -- Used to underline "Error" diagnostics
    LspDiagnosticsUnderlineWarning       { sp=getColor('ORANGE'), gui="undercurl" }, -- Used to underline "Warning" diagnostics
    LspDiagnosticsUnderlineInformation   { sp=getColor('YELLOW'), gui="undercurl" }, -- Used to underline "Information" diagnostics
    LspDiagnosticsUnderlineHint          { sp=getColor('BLUE'), gui="undercurl" }, -- Used to underline "Hint" diagnostics

    -- LspDiagnosticsFloatingError          { }, -- Used to color "Error" diagnostic messages in diagnostics float
    -- LspDiagnosticsFloatingWarning        { }, -- Used to color "Warning" diagnostic messages in diagnostics float
    -- LspDiagnosticsFloatingInformation    { }, -- Used to color "Information" diagnostic messages in diagnostics float
    -- LspDiagnosticsFloatingHint           { }, -- Used to color "Hint" diagnostic messages in diagnostics float

    -- LspDiagnosticsSignError              { }, -- Used for "Error" signs in sign column
    -- LspDiagnosticsSignWarning            { }, -- Used for "Warning" signs in sign column
    -- LspDiagnosticsSignInformation        { }, -- Used for "Information" signs in sign column
    -- LspDiagnosticsSignHint               { }, -- Used for "Hint" signs in sign column

    -- LspCodeLens                          { }, -- Used to color the virtual text of the codelens

    ------------------------------------ Tree Sitter ------------------------------------

    TSAnnotation         { red }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
    TSBoolean            { purple }, -- For booleans.
    TSCharacter          { yellow }, -- For characters.
    TSConditional        { red }, -- For keywords related to conditionnals.
    TSConstBuiltin       { red }, -- For constant that are built in the language: `nil` in Lua.
    TSConstMacro         { red }, -- For constants that are defined by macros: `NULL` in C.
    TSConstant           { orange }, -- For constants
    TSConstructor        { green }, -- For constructor calls and definitions: `{ }` in Lua, and Java constructors.
    TSEmphasis           { regular, gui="bold,underline" }, -- For text to be represented with emphasis.
    TSError              { regular }, -- For syntax/parser errors.
    TSException          { red }, -- For exception related keywords.
    TSField              { regular }, -- For fields.
    TSFloat              { purple }, -- For floats.
    TSFuncBuiltin        { red }, -- For builtin functions: `table.insert` in Lua.
    TSFuncMacro          { red }, -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
    TSFunction           { green }, -- For function (calls and definitions).
    TSInclude            { red }, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
    TSKeyword            { red }, -- For keywords that don't fall in previous categories.
    TSKeywordFunction    { red }, -- For keywords used to define a fuction.
    TSLabel              { red }, -- For labels: `label:` in C and `:label:` in Lua.
    TSLiteral            { regular }, -- Literal text.
    TSMethod             { green }, -- For method calls and definitions.
    TSNamespace          { blue }, -- For identifiers referring to modules and namespaces.
    TSNumber             { purple }, -- For integers.
    TSOperator           { red }, -- For any operator: `+`, but also `->` and `*` in C.
    TSParameter          { orange }, -- For parameters of a function.
    TSParameterReference { orange }, -- For references to parameters of a function.
    TSProperty           { regular }, -- Same as `TSField`.
    TSPunctDelimiter     { regular }, -- For delimiters ie: `.`
    TSPunctSpecial       { regular }, -- For special punctutation that does not fall in the catagories before.
    TSRepeat             { red }, -- For keywords related to loops.
    TSString             { yellow }, -- For strings.
    TSStringEscape       { yellow }, -- For escape characters within a string.
    TSStringRegex        { yellow }, -- For regexes.
    TSStrong             { regular, gui="bold" }, -- For text to be represented with strong.
    TSTag                { blue }, -- For tags ie. <`Container>`>
    TSTagDelimiter       { regular }, -- For delimiters ie: `<`Container`/>`
    TSText               { yellow }, -- For strings considered text in a markup language.
    TSTitle              { regular, gui="bold"  }, -- Text that is part of a title.
    TSType               { green }, -- For types.
    TSTypeBuiltin        { blue }, -- For builtin types (you guessed it, right ?).
    TSURI                { yellow }, -- Any URI like a link or email.
    TSUnderline          { regular, gui="underline" }, -- For text to be represented with an underline.
    TSVariable           { regular }, -- Any variable name that does not have another highlight.
    TSVariableBuiltin    { orange }, -- Variable names that are defined by the languages, like `this` or `self`.
    -- TSStrike             { };    -- For strikethrough text.
    -- TSStrike             { };    -- For strikethrough text.
    -- TSComment            { };    -- For comment blocks.
    -- TSAttribute          { };    -- (unstable) TODO: docs
    -- TSNone               { };    -- TODO: docs
    -- TSPunctBracket       { }, -- For brackets and parens.
  }
end)

-- return our parsed theme for extension or use else where.
return theme

-- vi:nowrap
