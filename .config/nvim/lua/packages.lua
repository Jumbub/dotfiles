require('packer').startup(function()
  use 'christianrondeau/vim-base64' -- Encoding base64 strings
  use 'dhruvasagar/vim-open-url' -- Open URL in browser
  use 'editorconfig/editorconfig-vim' -- Formatting config
  use 'junegunn/fzf' -- Install fzf
  use 'junegunn/fzf.vim' -- Install fzf for vim
  use 'mhartington/formatter.nvim' -- Auto formatter
  use 'scrooloose/nerdtree' -- Directory tree
  use 'tpope/vim-abolish' -- Word modifications
  use 'tpope/vim-commentary' -- Quick comments
  use 'tpope/vim-eunuch' -- File helpers
  use 'tpope/vim-fugitive' -- Git wrapper
  use 'tpope/vim-surround' -- Word wapping
  use 'wakatime/vim-wakatime' -- Track development time
  use 'wbthomason/packer.nvim' -- Package manager
  use { 'dhruvasagar/vim-prosession', requires = { use 'tpope/vim-obsession' }} -- Better session management
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' }} -- I think this is a dependency of another plugin

  -- Languages
  use 'hrsh7th/cmp-nvim-lsp' -- Autocomplete linker to LSP
  use 'hrsh7th/cmp-vsnip' -- Autocomplete linker to snippets
  use 'hrsh7th/nvim-cmp' -- Autocomplete tool
  use 'hrsh7th/vim-vsnip' -- Snippet tool (primarily used as auto-complete helper)
  use 'neovim/nvim-lspconfig' -- Configs
  use 'nvim-treesitter/nvim-treesitter-textobjects' -- Extra language information
  use 'nvim-treesitter/playground' -- TS playground
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- Language parser
  use 'puremourning/vimspector' -- Debugger
  use 'metakirby5/codi.vim' -- Code scratchpad

  -- Visuals
  use 'Xuyuanp/scrollbar.nvim' -- Scroll bar
  use 'karb94/neoscroll.nvim' -- Smooth scroll
  use 'norcalli/nvim-colorizer.lua' -- Highlight colour codes
  use 'rktjmp/lush.nvim' -- Colour scheme helper
  use { 'iamcco/markdown-preview.nvim', ft = 'markdown', run = 'cd app && yarn install' } -- Markdown preview
  use "lukas-reineke/indent-blankline.nvim" -- Indent guides
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Git signs
end);

vim.g.prosession_dir = '/home/jamie/workspaces/vim/' -- Set the directory to create prosessions
vim.g.NERDTreeQuitOnOpen = true -- Close tree on opening a file
vim.g.NERDTreeWinSize = 60 -- Size of frame
vim.g.NERDTreeMinimalUI = true -- Remove boomarks and help text
vim.g.NERDTreeMinimalMenu = true -- Single line modifiers
vim.g['codi#interpreters'] = { -- Setup REPL commands for Codi
  javascript = {
    bin = 'node'
  },
  typescript = {
    bin = 'ts-node'
  },
}
-- Telescope
require 'telescope'.setup()

-- LSP
require 'nvim-treesitter.configs'.setup { ensure_installed = 'maintained', highlight = { enable = true } };
local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = {"src/parser.c"}
  },
  filetype = "gotmpl",
  used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl", "yaml"}
}

-- Visual
require('neoscroll').setup()
require('neoscroll.config').set_mappings({
  ['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '75'}},
  ['<C-d>'] = {'scroll', {'vim.wo.scroll', 'true', '75'}},
  ['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '150'}},
  ['<C-f>'] = {'scroll', {'vim.api.nvim_win_get_height(0)', 'true', '150'}},
  ['zt'] = {'zt', {'50'}},
  ['zz'] = {'zz', {'50'}},
  ['zb'] = {'zb', {'50'}},
})
require('gitsigns').setup {
  signs = {
    add = { hl = 'DiffAdd', text = '+' },
    change = { hl = 'DiffChange', text = '~' },
    delete = { hl = 'DiffDelete', text = '_' },
    topdelete = { hl = 'DiffDelete', text = '‾' },
    changedelete = { hl = 'DiffDelete', text = '~' },
  },
}

require("indent_blankline").setup {
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
}

vim.g.scrollbar_right_offset = 0
vim.g.scrollbar_shape = {
  head = "█",
  body = "█",
  tail = "█",
}
vim.g.scrollbar_highlight = {
  head = "ShadyDark",
  body = "ShadyDark",
  tail = "ShadyDark",
}
vim.cmd [[
  augroup ScrollbarInit
    autocmd!
    autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
    autocmd WinEnter * silent! lua require('scrollbar').show()
    autocmd WinLeave,BufLeave,BufWinLeave * silent! lua require('scrollbar').clear()
  augroup end
]]
