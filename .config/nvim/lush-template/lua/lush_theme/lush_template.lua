--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see the README and the contents of the `examples` folder.

--
-- Note: Because this is lua file, vim will append your file to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require('lush')
local hsl = lush.hsl

-- Custom helper
local getenv = os.getenv;
local print = print;
local getColor = function(color)
  return hsl(getenv('THEME_' .. color))
end

local theme = lush(function()
  return {
    -- Custom
    regular { fg=getColor('WHITE'), bg=getColor('BLACK') },
    irregular { fg=getColor('GRAY'), bg=getColor('BLACK') },
    invert { fg=getColor('BLACK'), bg=getColor('WHITE') },
    offset { fg=getColor('WHITE'), bg=getColor('GRAY_DARKER') },
    dark { bg=getColor('GRAY_DARK') },
    highlight { bg=getColor('GRAY_DARK'), gui="underline" },
    shadyDark { fg=getColor('GRAY_DARKER'), bg=getColor('GRAY') }, -- Popup menu: scrollbar.
    shady { fg=getColor('GRAY_DARK'), bg=getColor('GRAY_LIGHT') }, -- Popup menu: selected item.
    shadyLight { fg=getColor('GRAY'), bg=getColor('GRAY_LIGHTER') }, -- Popup menu: Thumb of the scrollbar.
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
    strongGreen { fg=getColor('GREEN'), gui='bold' },
    purple { fg=getColor('PURPLE') },
    pink { fg=getColor('PINK') },
    bold { gui='bold' },


    -- The following are all the Neovim default highlight groups from
    -- docs as of 0.5.0-812, to aid your theme creation. Your themes should
    -- probably style all of these at a bare minimum.
    --
    -- Referenced/linked groups must come before being referenced/lined,
    -- so the order shown ((mostly) alphabetical) is likely
    -- not the order you will end up with.
    --
    -- You can uncomment these and leave them empty to disable any
    -- styling for that group (meaning they mostly get styled as Normal)
    -- or leave them commented to apply vims default colouring or linking.

    ColorColumn  { dark }, -- used for the columns set with 'colorcolumn'
    Conceal      { pink }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    -- Cursor       { }, -- character under the cursor
    -- lCursor      { }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn { dark }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine   { dark }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory    { green }, -- directory names (and other special names in listings)
    DiffAdd      { green }, -- diff mode: Added line |diff.txt|
    DiffChange   { yellow }, -- diff mode: Changed line |diff.txt|
    DiffDelete   { red }, -- diff mode: Deleted line |diff.txt|
    DiffText     { yellow }, -- diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer  { irregular }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    TermCursor   { shadyDark }, -- cursor in a focused terminal
    -- TermCursorNC { }, -- cursor in an unfocused terminal
    ErrorMsg     { redBg }, -- error messages on the command line
    VertSplit    { shadyDark }, -- the column separating vertically split windows
    Folded       { shady }, -- line used for closed folds
    FoldColumn   { shady }, -- 'foldcolumn'
    SignColumn   { regular }, -- column where |signs| are displayed
    IncSearch    { dark }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Substitute   { yellowBg }, -- |:substitute| replacement text highlighting
    LineNr       { irregular }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr { pink }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen   { blueBg }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg      { bold }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea      { regular }, -- Area for messages and cmdline
    MsgSeparator { shady }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg      { green }, -- |more-prompt|
    NonText      { blue }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal       { regular }, -- normal text
    Comment       { irregular }, -- normal text
    NormalFloat  { offset }, -- Normal text in floating windows.
    -- NormalNC     { }, -- normal text in non-current windows
    Pmenu        { offset }, -- Popup menu: normal item.
    PmenuSel     { shady }, -- Popup menu: selected item.
    PmenuSbar    { shadyDark }, -- Popup menu: scrollbar.
    PmenuThumb   { shadyLight }, -- Popup menu: Thumb of the scrollbar.
    Question     { green }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine { yellowBg }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search       { highlight }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    SpecialKey   { blue }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace| SpellBad  Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.  SpellCap  Word that should start with a capital. |spell| Combined with the highlighting used otherwise.  SpellLocal  Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    -- SpellRare    { gui='undercurl' }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    StatusLine   { greenLc }, -- status line of current window
    StatusLineNC { shadyDark }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine      { shadyLight }, -- tab pages line, not active tab page label
    TabLineFill  { shadyDark }, -- tab pages line, where there are no labels
    TabLineSel   { irregular }, -- tab pages line, active tab page label
    Title        { pink }, -- titles for output from ":set all", ":autocmd" etc.
    Visual       { dark }, -- Visual mode selection
    VisualNOS    { irregular }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg   { red }, -- warning messages
    Whitespace   { blue }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    WildMenu     { yellowBg }, -- current match in 'wildmenu' completion

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.

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

    -- ("Ignore", below, may be invisible...)
    -- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|

    Error          { redBg }, -- (preferred) any erroneous construct

    Todo           { yellowBg }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client. Some other LSP clients may use
    -- these groups, or use their own. Consult your LSP client's documentation.

    -- LspDiagnosticsError               { }, -- used for "Error" diagnostic virtual text
    -- LspDiagnosticsErrorSign           { }, -- used for "Error" diagnostic signs in sign column
    -- LspDiagnosticsErrorFloating       { }, -- used for "Error" diagnostic messages in the diagnostics float
    -- LspDiagnosticsWarning             { }, -- used for "Warning" diagnostic virtual text
    -- LspDiagnosticsWarningSign         { }, -- used for "Warning" diagnostic signs in sign column
    -- LspDiagnosticsWarningFloating     { }, -- used for "Warning" diagnostic messages in the diagnostics float
    -- LspDiagnosticsInformation         { }, -- used for "Information" diagnostic virtual text
    -- LspDiagnosticsInformationSign     { }, -- used for "Information" signs in sign column
    -- LspDiagnosticsInformationFloating { }, -- used for "Information" diagnostic messages in the diagnostics float
    -- LspDiagnosticsHint                { }, -- used for "Hint" diagnostic virtual text
    -- LspDiagnosticsHintSign            { }, -- used for "Hint" diagnostic signs in sign column
    -- LspDiagnosticsHintFloating        { }, -- used for "Hint" diagnostic messages in the diagnostics float
    -- LspReferenceText                  { }, -- used for highlighting "text" references
    -- LspReferenceRead                  { }, -- used for highlighting "read" references
    -- LspReferenceWrite                 { }, -- used for highlighting "write" references

    -- These groups are for the neovim tree-sitter highlights.
    -- As of writing, tree-sitter support is a WIP, group names may change.
    -- By default, most of these groups link to an appropriate Vim group,
    -- TSError -> Error for example, so you do not have to define these unless
    -- you explicitly want to support Treesitter's improved syntax awareness.

    TSError              { regular }, -- For syntax/parser errors.
    TSPunctDelimiter     { regular }, -- For delimiters ie: `.`
    TSTag                { blue }, -- For tags ie. <`Container>`>
    TSTagDelimiter       { regular }, -- For delimiters ie: `<`Container`/>`
    TSPunctBracket       { }, -- For brackets and parens.
    TSPunctSpecial       { regular }, -- For special punctutation that does not fall in the catagories before.
    TSConstant           { orange }, -- For constants
    TSConstBuiltin       { red }, -- For constant that are built in the language: `nil` in Lua.
    TSConstMacro         { red }, -- For constants that are defined by macros: `NULL` in C.
    TSString             { yellow }, -- For strings.
    TSStringRegex        { yellow }, -- For regexes.
    TSStringEscape       { yellow }, -- For escape characters within a string.
    TSCharacter          { yellow }, -- For characters.
    TSNumber             { purple }, -- For integers.
    TSBoolean            { purple }, -- For booleans.
    TSFloat              { purple }, -- For floats.
    TSFunction           { green }, -- For function (calls and definitions).
    TSFuncBuiltin        { red }, -- For builtin functions: `table.insert` in Lua.
    TSFuncMacro          { red }, -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
    TSParameter          { orange }, -- For parameters of a function.
    TSParameterReference { orange }, -- For references to parameters of a function.
    TSMethod             { green }, -- For method calls and definitions.
    TSField              { regular }, -- For fields.
    TSProperty           { regular }, -- Same as `TSField`.
    TSConstructor        { regular }, -- For constructor calls and definitions: `{ }` in Lua, and Java constructors.
    TSConditional        { red }, -- For keywords related to conditionnals.
    TSRepeat             { red }, -- For keywords related to loops.
    TSLabel              { red }, -- For labels: `label:` in C and `:label:` in Lua.
    TSOperator           { red }, -- For any operator: `+`, but also `->` and `*` in C.
    TSKeyword            { red }, -- For keywords that don't fall in previous categories.
    TSKeywordFunction    { red }, -- For keywords used to define a fuction.
    TSException          { red }, -- For exception related keywords.
    TSType               { strongGreen }, -- For types.
    TSTypeBuiltin        { blue }, -- For builtin types (you guessed it, right ?).
    TSNamespace          { blue }, -- For identifiers referring to modules and namespaces.
    TSInclude            { red }, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
    TSAnnotation         { red }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
    TSText               { yellow }, -- For strings considered text in a markup language.
    TSStrong             { regular, gui="bold" }, -- For text to be represented with strong.
    TSEmphasis           { regular, gui="bold,underline" }, -- For text to be represented with emphasis.
    TSUnderline          { regular, gui="underline" }, -- For text to be represented with an underline.
    TSTitle              { regular, gui="bold"  }, -- Text that is part of a title.
    TSLiteral            { regular }, -- Literal text.
    TSURI                { yellow }, -- Any URI like a link or email.
    TSVariable           { regular }, -- Any variable name that does not have another highlight.
    TSVariableBuiltin    { orange }, -- Variable names that are defined by the languages, like `this` or `self`.

    -- hacks
    shorthand_property_identifier {orange},
    TSshorthand_property_identifier {orange},
    TSShorthandPropertyIdentifier {orange},
  }
end)

-- return our parsed theme for extension or use else where.
return theme

-- vi:nowrap
