-- stylua: ignore start
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
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is a lua file, vim will append it to the runtime,
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

local lush = require("lush")
local hsl = lush.hsl
local os = require("os")

local colors = {
  BLACK="#272822";
  WHITE="#dfdfd9";

  GRAY_DARKER_STILL="#34322A";
  GRAY_DARKER="#3A382F";
  GRAY_DARK="#5D5A4B";
  GRAY="#75715e";
  GRAY_LIGHT="#908D7E";
  GRAY_LIGHTER="#BAB8AE";
  GRAY_LIGHTER_STILL="#c7c6be";

  YELLOW_DARK="#b8af5c";
  YELLOW="#e6db74";
  YELLOW_LIGHT="#EBE28F";

  RED_DARK="#c71e5b";
  RED="#f92672";
  RED_LIGHT="#fa518e";

  ORANGE_DARK="#CA7818";
  ORANGE="#fd971f";
  ORANGE_LIGHT="#fdab4b";

  GREEN_DARK="#84b424";
  GREEN="#a6e22e";
  GREEN_LIGHT="#b7e757";

  BLUE_DARK="#51adbf";
  BLUE="#66d9ef";
  BLUE_LIGHT="#84e0f2";

  CYAN_DARK="#80BFB6";
  CYAN="#a1efe4";
  CYAN_LIGHT="#b3f2e9";

  PINK_DARK="#ca4cc0";
  PINK="#fd5ff0";
  PINK_LIGHT="#fd7ef3";

  PURPLE_DARK="#8b67cc";
  PURPLE="#ae81ff";
  PURPLE_LIGHT="#be9aff";
}

local getColor = function(color)
  local envColor = os.getenv("THEME_" .. color) or colors[color]
  return envColor or nil
end

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    regular { fg=getColor('WHITE') },
    irregular { fg=getColor('GRAY'), bg=getColor('BLACK') },
    irregularSymbols { fg=getColor('GRAY_DARKER_STILL') },
    invert { fg=getColor('BLACK'), bg=getColor('WHITE') },
    offset { fg=getColor('WHITE'), bg=getColor('GRAY_DARKER') },
    offsetLessSubtle { bg=getColor('GRAY_DARKER'), fg=getColor('GRAY_LIGHTER') },
    offsetSubtle { fg=getColor('GRAY'), bg=getColor('GRAY_DARKER') },
    grayBg { bg=getColor('GRAY') },
    darkGrayBg { bg=getColor('GRAY_DARK') },
    darkerGrayBg { bg=getColor('GRAY_DARKER') },
    shadyDarker { fg=getColor('BLACK'), bg=getColor('GRAY_DARKER') },
    shadyDark { fg=getColor('GRAY_DARKER'), bg=getColor('GRAY') },
    shady { fg=getColor('GRAY_DARK'), bg=getColor('GRAY_LIGHT') },
    shadyLight { fg=getColor('GRAY'), bg=getColor('GRAY_LIGHTER') },
    red { fg=getColor('RED') },
    redBg { bg=getColor('RED'), fg=getColor('BLACK') },
    yellow { fg=getColor('YELLOW') },
    yellowBg { bg=getColor('YELLOW'), fg=getColor('BLACK') },
    blue { fg=getColor('BLUE'), gui='italic' },
    blueUl { fg=getColor('BLUE'), gui='underline' },
    blueBg { fg=getColor('BLACK'), bg=getColor('BLUE'), gui='italic' },
    orange { fg=getColor('ORANGE'), gui='italic' },
    orangeBg { bg=getColor('ORANGE'), fg=getColor('BLACK'), gui='italic' },
    green { fg=getColor('GREEN') },
    purple { fg=getColor('PURPLE') },
    pink { fg=getColor('PINK') },
    strong { gui='bold' },

    -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
    -- groups, mostly used for styling UI elements.
    -- Comment them out and add your own properties to override the defaults.
    -- An empty definition `{}` will clear all styling, leaving elements looking
    -- like the 'Normal' group.
    -- To be able to link to a group, it must already be defined, so you may have
    -- to reorder items as you go.
    --
    -- See :h highlight-groups
    --
    ColorColumn    { darkGrayBg }, -- Columns set with 'colorcolumn'
    Conceal        { pink }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor         { darkGrayBg }, -- Character under the cursor
    CurSearch      { darkGrayBg }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
    -- lCursor        { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM       { }, -- Like Cursor, but used when in IME mode |CursorIM|
    -- CursorColumn   { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine     { darkerGrayBg }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory      { blue }, -- Directory names (and other special names in listings)
    DiffAdd        { green }, -- Diff mode: Added line |diff.txt|
    DiffChange     { yellow }, -- Diff mode: Changed line |diff.txt|
    DiffDelete     { red }, -- Diff mode: Deleted line |diff.txt|
    DiffText       { redBg }, -- Diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer    { irregular }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    TermCursor     { shadyDark }, -- Cursor in a focused terminal
    -- TermCursorNC   {  }, -- Cursor in an unfocused terminal
    ErrorMsg       { red }, -- Error messages on the command line
    VertSplit      { shadyDarker }, -- Column separating vertically split windows
    Folded         { shady }, -- Line used for closed folds
    FoldColumn     { shady }, -- 'foldcolumn'
    SignColumn     {  }, -- Column where |signs| are displayed
    IncSearch      { darkGrayBg }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Substitute     { yellowBg }, -- |:substitute| replacement text highlighting
    LineNr         { irregular }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    LineNrAbove    { irregular}, -- Line number for when the 'relativenumber' option is set, above the cursor line
    LineNrBelow    { irregular}, -- Line number for when the 'relativenumber' option is set, below the cursor line
    -- CursorLineNr   { }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    -- CursorLineFold { }, -- Like FoldColumn when 'cursorline' is set for the cursor line
    -- CursorLineSign { }, -- Like SignColumn when 'cursorline' is set for the cursor line
    MatchParen     { grayBg }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg        { strong }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea        { regular }, -- Area for messages and cmdline
    MsgSeparator   { shady }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg        { green }, -- |more-prompt|
    NonText        { blue }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal         { regular }, -- Normal text
    NormalFloat    { offset }, -- Normal text in floating windows.
    FloatBorder    { shadyDarker }, -- Border of floating windows.
    -- FloatTitle     { }, -- Title of floating windows.
    -- NormalNC       { }, -- normal text in non-current windows
    Pmenu          { offsetSubtle }, -- Popup menu: Normal item.
    PmenuSel       {  offset }, -- Popup menu: Selected item.
    -- PmenuKind      { }, -- Popup menu: Normal item "kind"
    -- PmenuKindSel   { }, -- Popup menu: Selected item "kind"
    -- PmenuExtra     { }, -- Popup menu: Normal item "extra text"
    -- PmenuExtraSel  { }, -- Popup menu: Selected item "extra text"
    PmenuSbar      { shadyDarker }, -- Popup menu: Scrollbar.
    PmenuThumb     { shadyDark }, -- Popup menu: Thumb of the scrollbar.
    Question       { green }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine   { yellowBg }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search         { darkGrayBg }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    SpecialKey     { irregular }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    -- SpellBad       { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    -- SpellCap       { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    -- SpellLocal     { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    -- SpellRare      { }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    StatusLine     { offsetLessSubtle }, -- Status line of current window
    -- StatusLineNC   { }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    -- TabLine        { }, -- Tab pages line, not active tab page label
    -- TabLineFill    { }, -- Tab pages line, where there are no labels
    -- TabLineSel     { }, -- Tab pages line, active tab page label
    Title          { strong }, -- Titles for output from ":set all", ":autocmd" etc.
    Visual         { darkGrayBg }, -- Visual mode selection
    -- VisualNOS      { }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg     { red }, -- Warning messages
    Whitespace     { irregular }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    Winseparator   { irregularSymbols }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    -- WildMenu       { }, -- Current match in 'wildmenu' completion
    -- WinBar         {  }, -- Window bar of current window
    -- WinBarNC       { }, -- Window bar of not-current windows

    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    --
    -- See :h group-name
    --
    -- Uncomment and edit if you want more specific syntax highlighting.

    Comment        { irregular }, -- Any comment

    Constant       { purple }, -- (*) Any constant
    String         { yellow }, --   A string constant: "this is a string"
    Character      { String }, --   A character constant: 'c', '\n'
    -- Number         { }, --   A number constant: 234, 0xff
    -- Boolean        { }, --   A boolean constant: TRUE, false
    -- Float          { }, --   A floating point constant: 2.3e10

    Identifier     { regular }, -- (*) Any variable name
    Function       { blue }, --   Function name (also: methods for classes)

    Statement      { red }, -- (*) Any statement
    -- Conditional    {blue }, --   if, then, else, endif, switch, etc.
    -- Repeat         {blue }, --   for, do, while, etc.
    -- Label          {blue }, --   case, default, etc.
    -- Operator       {blue }, --   "sizeof", "+", "*", etc.
    -- Keyword        {blue }, --   any other keyword
    -- Exception      {blue }, --   try, catch, throw

    PreProc        { pink }, -- (*) Generic Preprocessor
    Include        { red }, --   Preprocessor #include
    -- Define         { }, --   Preprocessor #define
    -- Macro          { }, --   Same as Define
    -- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

    Type           { green }, -- (*) int, long, char, etc.
    -- StorageClass   { red }, --   static, register, volatile, etc.
    -- Structure      { red }, --   struct, union, enum, etc.
    -- Typedef        { red }, --   A typedef

    Special        { regular }, -- (*) Any special symbol
    -- SpecialChar    { }, --   Special character in a constant
    Tag            { red }, --   You can use CTRL-] on this
    -- Delimiter      { regular }, --   Character that needs attention
    SpecialComment { purple }, --   Special things inside a comment (e.g. '\n')
    -- Debug          { }, --   Debugging statements

    Underlined     { blue, gui = "underline" }, -- Text that stands out, HTML links
    -- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error          { redBg }, -- Any erroneous construct
    Todo           { yellowBg }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- LspReferenceText            { } , -- Used for highlighting "text" references
    -- LspReferenceRead            { } , -- Used for highlighting "read" references
    -- LspReferenceWrite           { } , -- Used for highlighting "write" references
    -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
    -- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- DiagnosticError            { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticWarn             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticInfo             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticHint             { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticOk               { } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
    -- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
    -- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
    -- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
    -- DiagnosticVirtualTextOk    { } , -- Used for "Ok" diagnostic virtual text.
    -- DiagnosticUnderlineError   { } , -- Used to underline "Error" diagnostics.
    -- DiagnosticUnderlineWarn    { } , -- Used to underline "Warn" diagnostics.
    -- DiagnosticUnderlineInfo    { } , -- Used to underline "Info" diagnostics.
    -- DiagnosticUnderlineHint    { } , -- Used to underline "Hint" diagnostics.
    -- DiagnosticUnderlineOk      { } , -- Used to underline "Ok" diagnostics.
    -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingOk       { } , -- Used to color "Ok" diagnostic messages in diagnostics float.
    -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
    -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
    -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
    -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.
    -- DiagnosticSignOk           { } , -- Used for "Ok" signs in sign column.

    -- Tree-Sitter syntax groups.
    --
    -- See :h treesitter-highlight-groups, some groups may not be listed,
    -- submit a PR fix to lush-template!
    --
    -- Tree-Sitter groups are defined with an "@" symbol, which must be
    -- specially handled to be valid lua code, we do this via the special
    -- sym function. The following are all valid ways to call the sym function,
    -- for more details see https://www.lua.org/pil/5.html
    --
    -- sym("@text.literal")
    -- sym('@text.literal')
    -- sym"@text.literal"
    -- sym'@text.literal'
    --
    -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

    -- sym"@text.literal"      { }, -- Comment
    -- sym"@text.reference"    { }, -- Identifier
    -- sym"@text.title"        { }, -- Title
    -- sym"@text.uri"          { }, -- Underlined
    -- sym"@text.underline"    { }, -- Underlined
    -- sym"@text.todo"         { }, -- Todo
    -- sym"@comment"           { }, -- Comment
    -- sym"@punctuation"       { }, -- Delimiter
    -- sym"@constant"          { }, -- Constant
    -- sym"@constant.builtin"  { }, -- Special
    -- sym"@constant.macro"    { }, -- Define
    -- sym"@define"            { }, -- Define
    -- sym"@macro"             { }, -- Macro
    -- sym"@string"            { }, -- String
    -- sym"@string.escape"     { }, -- SpecialChar
    -- sym"@string.special"    { }, -- SpecialChar
    -- sym"@character"         { }, -- Character
    -- sym"@character.special" { }, -- SpecialChar
    -- sym"@number"            { }, -- Number
    -- sym"@boolean"           { }, -- Boolean
    -- sym"@float"             { }, -- Float
    -- sym"@function"          { }, -- Function
    -- sym"@function.builtin"  { }, -- Special
    -- sym"@function.macro"    { }, -- Macro
    sym"@parameter"         { orange }, -- Identifier
    -- sym"@method"            { }, -- Function
    -- sym"@field"             { }, -- Identifier
    -- sym"@property"          { }, -- Identifier
    -- sym"@constructor"       { }, -- Special
    -- sym"@conditional"       { }, -- Conditional
    -- sym"@repeat"            { }, -- Repeat
    -- sym"@label"             { }, -- Label
    -- sym"@operator"          { }, -- Operator
    -- sym"@keyword"           { }, -- Keyword
    -- sym"@exception"         { }, -- Exception
    -- sym"@variable"          { }, -- Identifier
    -- sym"@type"              { }, -- Type
    sym"@type.qualifier"              { red }, -- Type
    sym"@type.builtin"              { blue }, -- Type
    -- sym"@storageclass"      { }, -- StorageClass
    -- sym"@structure"         { }, -- Structure
    sym"@namespace"         { }, -- Identifier
    -- sym"@include"           { }, -- Include
    -- sym"@preproc"           { }, -- PreProc
    sym"@debug"             {orange }, -- Debug
    -- sym"@tag"               { }, -- Tag
    sym"@tag.delimiter"               { regular }, -- Tag
    sym"@tag.attribute"               { green }, -- Tag

    sym'@lsp.type.class' {},
    sym'@lsp.type.comment' {},
    sym'@lsp.type.decorator' {},
    sym'@lsp.type.enum' {},
    sym'@lsp.type.enumMember' {},
    sym'@lsp.type.function' {},
    sym'@lsp.type.interface' {},
    sym'@lsp.type.macro' {},
    sym'@lsp.type.method' {},
    sym'@lsp.type.namespace' {},
    sym'@lsp.type.parameter' {},
    sym'@lsp.type.property' {},
    sym'@lsp.type.struct' {},
    sym'@lsp.type.type' {},
    sym'@lsp.type.typeParameter' {},
    sym'@lsp.type.variable' {},
  }
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
-- stylua: ignore end
