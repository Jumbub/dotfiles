-- Options
(function()
  vim.o.clipboard = 'unnamedplus' -- Share clipboard with system
  vim.o.inccommand = 'split' -- Show substitude command effects as you type
  vim.o.relativenumber = true -- Use relative line numbers
  vim.o.signcolumn = 'yes' -- Always display gutter (prevent git gutter from bouncing on save
  vim.o.statusline = '%<%f  %h%m%r%=%(%l,%c%V%)' -- Status line text
  vim.o.swapfile = false -- Don't bother using swap files
  vim.o.termguicolors = true -- Use terminal colours
  vim.o.undodir = '/home/jamie/.vim/undodir' -- Set undo history file
  vim.o.undofile = true -- Persist undo history between sessions
  vim.o.rtp = vim.o.rtp .. ',/home/jamie/.config/nvim/lush-template' -- Load local colour scheme
  -- vim.o.cmdheight = 2 -- Avoid the 'hit enter' prompt caused by multi line commands
end)();

-- Plugins
require('packer').startup(function()
  use 'dhruvasagar/vim-open-url' -- Open URL in browser
  use 'tanvirtin/monokai.nvim' -- Monokai theme
  use 'editorconfig/editorconfig-vim' -- Format definitions
  use 'nvim-lua/plenary.nvim' -- Lua helper functions
  use 'neovim/nvim-lspconfig' -- LSP Core
  use 'tpope/vim-abolish' -- Word modifications
  use 'tpope/vim-commentary' -- Quick comments
  use 'tpope/vim-eunuch' -- File helpers
  use 'tpope/vim-fugitive' -- Git wrapper
  use 'tpope/vim-surround' -- Word wapping
  use 'wakatime/vim-wakatime' -- Track development time
  use 'wbthomason/packer.nvim' -- Package manager
  use 'rktjmp/lush.nvim' -- Colour scheme helper

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- Language parser
  require'nvim-treesitter.configs'.setup { ensure_installed = 'maintained', highlight = { enable = true } };

  use 'karb94/neoscroll.nvim' -- Smooth scroll
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

  use { 'dhruvasagar/vim-prosession', requires = {  -- Better session management
    use 'tpope/vim-obsession' -- Session management
  }}
  vim.g.prosession_dir = '/home/jamie/workspaces/vim/' -- Set the directory to create prosessions

  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'} -- Markdown preview
  vim.g.mkdp_auto_close = 1

  use 'sbdchd/neoformat' -- Auto formatter
  vim.g.neoformat_enabled_php = {'phpcbf'}
  vim.g.neoformat_enabled_python = {'autopep8'}
  vim.g.neoformat_only_msg_on_error = 1 -- Throw error on failed formatting

  use 'mhinz/vim-signify' -- Inline git line statuses
  vim.g.signify_sign_add = '+'
  vim.g.signify_sign_delete = '_'
  vim.g.signify_sign_delete_first_line = '‾'
  vim.g.signify_sign_change = '~'
  vim.g.signify_sign_change_delete = 'x'

  use 'junegunn/fzf' -- Install fzf
  use 'junegunn/fzf.vim' -- Install fzf for vim

  use 'scrooloose/nerdtree' -- Directory tree
  vim.g.NERDTreeQuitOnOpen = 1 -- Close tree on opening a file
  vim.g.NERDTreeWinSize = 60 -- Size of frame

end);


-- LSP
(function()
  local nvim_lsp = require('lspconfig')

  local onAttach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }
  end

  require'lspconfig'.tsserver.setup {}

  vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gDD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', '<leader>c', '<cmd>lua vim.lsp.buf.code_action()<CR>', {silent=true})
end)();

-- Variables
(function()
  vim.g.mapleader = ','
end)();

-- Key Mappings
(function()
  -- Better undo
  vim.api.nvim_set_keymap('n', 'U', ':redo<CR>', {silent=true, noremap=true})

  -- Case insenstive search
  vim.api.nvim_set_keymap('n', '/', '/\\c', {})
  vim.api.nvim_set_keymap('n', '?', '?\\c', {})
  vim.api.nvim_set_keymap('v', '/', '/\\c', {})
  vim.api.nvim_set_keymap('v', '?', '?\\c', {})

  -- Fuzzy word search
  vim.api.nvim_set_keymap('n', '<leader>j', ':Rg <CR>', {})
  vim.api.nvim_set_keymap('v', '<leader>j', '"sy:Rg <C-r>s<CR>', {})

  -- Replace
  vim.api.nvim_set_keymap('v', '<leader>c', 'yq/p<CR>Ncgn', {})

  -- Quickfix
  vim.api.nvim_set_keymap('n', '<C-k>', ':cp<CR>', {})
  vim.api.nvim_set_keymap('n', '<C-j>', ':cn<CR>', {})
  vim.api.nvim_set_keymap('n', '<C-h>', ':cclose<CR>', {})
  vim.api.nvim_set_keymap('n', '<C-l>', ':copen<CR>', {})

  -- Sessions
  vim.api.nvim_set_keymap('n', '<leader>p', ":call fzf#run({'source': 'find ~/workspaces/vim/*', 'sink': 'Prosession', 'down': '10', 'options': '--tiebreak=end'})<CR>", {silent=true}) -- Fuzzy find session

  -- Files
  vim.api.nvim_set_keymap('n', '<leader>m', 'bufexists(expand("%")) ? ":NERDTreeFind<CR>" : ":NERDTree<CR>"', {expr=true,silent=true})
  vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', {})
end)();

-- Colours
(function()
  require('monokai').classic.white = os.getenv('THEME_WHITE')
  require('monokai').classic.black = os.getenv('THEME_BLACK')
  require('monokai').classic.base1 = os.getenv('THEME_GRAY_DARKER_STILL')
  require('monokai').classic.base2 = os.getenv('THEME_BLACK')
  require('monokai').classic.base3 = os.getenv('THEME_GRAY_DARK')
  require('monokai').classic.base4 = os.getenv('THEME_GRAY')
  require('monokai').classic.base5 = os.getenv('THEME_GRAY_LIGHT')
  require('monokai').classic.base6 = os.getenv('THEME_GRAY_LIGHTER')
  require('monokai').classic.base7 = os.getenv('THEME_GRAY_LIGHTER_STILL')
  require('monokai').classic.border = os.getenv('THEME_GRAY')
  require('monokai').classic.brown = os.getenv('THEME_GRAY')
  require('monokai').classic.grey = os.getenv('THEME_GREY')
  require('monokai').classic.pink = os.getenv('THEME_RED')
  require('monokai').classic.green = os.getenv('THEME_GREEN')
  require('monokai').classic.aqua = os.getenv('THEME_BLUE')
  require('monokai').classic.yellow = os.getenv('THEME_YELLOW')
  require('monokai').classic.orange = os.getenv('THEME_ORANGE')
  require('monokai').classic.purple = os.getenv('THEME_PURPLE')
  require('monokai').classic.red = os.getenv('THEME_RED')
  require('monokai').classic.diff_add = os.getenv('THEME_GRAY_LIGHT')
  require('monokai').classic.diff_remove = os.getenv('THEME_RED')
  require('monokai').classic.diff_change = os.getenv('THEME_YELLOW')
  require('monokai').classic.diff_text = os.getenv('THEME_GRAY_LIGHT')

  vim.cmd('colorscheme monokai') -- Use local colour scheme
end)();
