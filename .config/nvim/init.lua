-- Global
do
  vim.o.clipboard = 'unnamedplus' -- Share clipboard with system
  vim.o.inccommand = 'split' -- Show substitude command effects as you type
  vim.o.relativenumber = true -- Use relative line numbers
  vim.o.signcolumn = 'yes' -- Always display gutter (prevent git gutter from bouncing on save
  vim.o.statusline = '%<%f  %h%m%r%=%(%l,%c%V%)' -- Status line text
  vim.o.swapfile = false -- Don't bother using swap files
  vim.o.termguicolors = true -- Use terminal colours
  vim.o.undodir = '/home/jamie/.vim/undodir' -- Set undo history file
  vim.o.undofile = true -- Persist undo history between sessions
  vim.o.rtp = vim.o.rtp .. ',/home/jamie/.config/nvim/monokai' -- Load local colour scheme
  vim.o.breakindent = true -- Maintain indentation when wrapping text
  vim.o.updatetime = 300 -- Cursor hold events

  vim.g.mapleader = ','
end

-- Plugins
require('packer').startup(function()
  use 'dhruvasagar/vim-open-url' -- Open URL in browser
  use 'editorconfig/editorconfig-vim' -- Format definitions
  use 'tpope/vim-abolish' -- Word modifications
  use 'tpope/vim-commentary' -- Quick comments
  use 'tpope/vim-eunuch' -- File helpers
  use 'tpope/vim-fugitive' -- Git wrapper
  use 'tpope/vim-surround' -- Word wapping
  use 'wakatime/vim-wakatime' -- Track development time
  use 'wbthomason/packer.nvim' -- Package manager

  -- Visuals
  use 'rktjmp/lush.nvim' -- Colour scheme helper
  use 'norcalli/nvim-colorizer.lua' -- Highlight colour codes
  use 'Xuyuanp/scrollbar.nvim' -- Scroll bar

  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  require('telescope').setup()

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- Language parser
  use 'nvim-treesitter/nvim-treesitter-textobjects' -- Extra language information
  require'nvim-treesitter.configs'.setup { ensure_installed = 'maintained', highlight = { enable = true } };

  use 'nvim-treesitter/playground' -- TS playground
  require "nvim-treesitter.configs".setup { }

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

  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Git signs
  require('gitsigns').setup {
    signs = {
      add = { hl = 'GitGutterAdd', text = '+' },
      change = { hl = 'GitGutterChange', text = '~' },
      delete = { hl = 'GitGutterDelete', text = '_' },
      topdelete = { hl = 'GitGutterDelete', text = '‾' },
      changedelete = { hl = 'GitGutterChange', text = '~' },
    },
  }

  use 'junegunn/fzf' -- Install fzf
  use 'junegunn/fzf.vim' -- Install fzf for vim

  use 'scrooloose/nerdtree' -- Directory tree
  vim.g.NERDTreeQuitOnOpen = 1 -- Close tree on opening a file
  vim.g.NERDTreeWinSize = 60 -- Size of frame

  if os.getenv('NVIM_COC') then
    use 'neoclide/coc.nvim' -- LSP
  else
    use 'neovim/nvim-lspconfig' -- Configs
    use 'hrsh7th/nvim-cmp' -- Autocomplete tool
    use 'hrsh7th/cmp-nvim-lsp' -- Autocomplete linker to LSP
    use {'ojroques/nvim-lspfuzzy', -- Fuzzy preview of code actions
      requires = {
        {'junegunn/fzf'},
        {'junegunn/fzf.vim'},
      },
    }
  end
end);

if os.getenv('NVIM_COC') then
  require('coc_lsp')()
else
  require('native_lsp')()
end

-- Keys
do
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

  -- Traverse wrapped lines
  vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })
end

-- Colours
do
  vim.cmd('colorscheme monokai') -- Use local colour scheme

  vim.cmd [[function! SynGroup()
      let l:s = synID(line('.'), col('.'), 1)
      echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
  endfun]]
end

do
  local default = {
      max_size = 10,
      min_size = 3,
      width = 1,
      right_offset = 1,
      excluded_filetypes = {},
      shape = {
          head = "▲",
          body = "█",
          tail = "▼",
      },
      highlight = {
          head = "Normal",
          body = "Normal",
          tail = "Normal",
      }
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
  vim.cmd [[augroup ScrollbarInit
    autocmd!
    autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
    autocmd WinEnter * silent! lua require('scrollbar').show()
    autocmd WinLeave,BufLeave,BufWinLeave * silent! lua require('scrollbar').clear()
  augroup end]]
end
