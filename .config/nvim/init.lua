-- Global
do
  vim.o.clipboard = 'unnamedplus' -- Share clipboard with system
  vim.o.inccommand = 'split' -- Show substitude command effects as you type
  vim.o.number = true -- Show curernt line number
  vim.o.relativenumber = true -- Use relative line numbers
  vim.o.signcolumn = 'yes' -- Always display gutter (prevent git gutter from bouncing on save
  vim.o.statusline = '%F  %h%m%r%=%(%l,%c%)' -- Status line text
  vim.o.swapfile = false -- Don't bother using swap files
  vim.o.termguicolors = true -- Use terminal colours
  vim.o.undodir = '/home/jamie/.vim/undodir' -- Set undo history file
  vim.o.undofile = true -- Persist undo history between sessions
  vim.o.rtp = vim.o.rtp .. ',/home/jamie/.config/nvim/monokai' -- Load local colour scheme
  vim.o.breakindent = true -- Maintain indentation when wrapping text
  vim.o.updatetime = 300 -- Cursor hold events
  vim.o.wrap = true -- Wrap preference
  vim.o.cmdheight = 2 -- Avoid "hit enter" text

  vim.g.mapleader = ','
end

-- Plugins
require('packer').startup(function()
  use 'christianrondeau/vim-base64' -- Encoding base64 strings
  use 'dhruvasagar/vim-open-url' -- Open URL in browser
  use 'editorconfig/editorconfig-vim' -- Formatting config
  use 'junegunn/fzf' -- Install fzf
  use 'junegunn/fzf.vim' -- Install fzf for vim
  use 'sbdchd/neoformat' -- Auto formatter
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
  use 'ojroques/nvim-lspfuzzy' -- Fuzzy preview of code actions
  use 'ray-x/lsp_signature.nvim' -- Function signature popup
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

-- Plugin Setup
do
  vim.g.prosession_dir = '/home/jamie/workspaces/vim/' -- Set the directory to create prosessions
  vim.g.neoformat_enabled_php = {'phpcbf'}
  vim.g.neoformat_enabled_python = {'autopep8'}
  vim.g.neoformat_enabled_cpp = {'clangformat'}
  vim.g.neoformat_only_msg_on_error = 1 -- Throw error on failed formatting
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

  -- Debugging
  vim.cmd [[
    function! GotoWindow(id)
        call win_gotoid(a:id)
    endfunction
  ]]
  vim.api.nvim_set_keymap('n', '<leader>dl', ':call vimspector#Launch()<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>dg', ':call vimspector#Continue()<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>dq', ':call vimspector#Reset()<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>dc', ':call GotoWindow(g:vimspector_session_windows.code)<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>dt', ':call GotoWindow(g:vimspector_session_windows.tagpage)<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>dv', ':call GotoWindow(g:vimspector_session_windows.variables)<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>dw', ':call GotoWindow(g:vimspector_session_windows.watches)<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ds', ':call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>do', ':call GotoWindow(g:vimspector_session_windows.output)<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>dj', '<Plug>VimspectorStepOver', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>dl', '<Plug>VimspectorStepInto', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>dh', '<Plug>VimspectorStepOut', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>dR', '<Plug>VimspectorRestart', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>dd', '<Plug>VimspectorRunToCursor', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>dbc', ':call vimspector#ClearBreakpoints()<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>db', '<Plug>VimspectorToggleBreakpoint', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>dcb', '<Plug>VimspectorToggleConditionalBreakpoint', { silent = true })
  vim.api.nvim_set_keymap('n', '<leader>di', '<Plug>VimspectorBalloonEval', { silent = true })
  vim.api.nvim_set_keymap('x', '<leader>di', '<Plug>VimspectorBalloonEval', { silent = true })

  -- Base64 encoding
  vim.api.nvim_set_keymap('v', ',64', ',btoa', {silent=true})
  vim.api.nvim_set_keymap('v', ',46', ',atob', {silent=true})
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
end

-- LSP Setup
do
  vim.o.completeopt = 'menuone,noselect'

  local onAttach = function(client, bufnr)
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false
        }
    )
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local function organize_imports()
    local params = {
      command = "_typescript.organizeImports",
      arguments = {vim.api.nvim_buf_get_name(0)},
      title = ""
    }
    vim.lsp.buf.execute_command(params)
  end

  local lspconfig = require('lspconfig')

  lspconfig.tsserver.setup {
    on_attach = onAttach,
    capabilities = capabilities,
    commands = {
      OrganizeImports = {
        organize_imports,
        description = "Organize Imports"
      }
    }
  }

  lspconfig.ccls.setup {
    on_attach = onAttach,
  }

  require 'lsp_signature'.setup({
    hint_enable = false,
    max_width = 100,
    transpancy = 0,
    handler_opts = {
      border = "none"
    },
  })

  vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gh', "<cmd>lua vim.lsp.buf.hover()<CR>", {silent=true})
  vim.api.nvim_set_keymap('n', 'gH', "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border='single'})<CR>", {silent=true})
  vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gDD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.code_action()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gS', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', {silent=true})

  require('lspfuzzy').setup { methods = {'textDocument/codeAction'} }

  local cmp = require 'cmp'
  cmp.setup {
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-u>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
        else
          fallback()
        end
      end,
    },
    sources = {
      { name = 'nvim_lsp' },
    },
  }

  local infoSigns = { Error = "•", Warning = "•", Hint = "•", Information = "•" }
  local infoColors = { "LspDiagnosticsDefaultError", "LspDiagnosticsDefaultWarning", "LspDiagnosticsDefaultInformation", "LspDiagnosticsDefaultHint" }

  for type, icon in pairs(infoSigns) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  function PrintDiagnostics(opts, bufnr, line_nr, client_id)
    opts = opts or {}

    bufnr = bufnr or 0
    line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)

    local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
    if vim.tbl_isempty(line_diagnostics) then return end

    for _, diagnostic in ipairs(line_diagnostics) do
      local output = string.format("%s", diagnostic.message or "")
      if #output > 140 then
        output = string.sub(output, 0, 140) .. '...'
      end
      vim.api.nvim_echo({{
        output,
        infoColors[diagnostic.severity or 4]
      }}, false, {})
      break
    end
  end

end

do
  -- On hover, show diagnostics in the echo view
  vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]

  -- When NERDtree is the last window, close vim
  vim.cmd [[ autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif ]]

  -- Manual format
  vim.cmd [[
    command! FF Neoformat
  ]]

  -- Format on save
  vim.cmd [[
    augroup fmt
      autocmd!
      autocmd BufWritePre *.tsx | Neoformat
    augroup END
  ]]

  -- Setup VimSpector debugger
  vim.cmd [[
    au VimEnter * :packadd! vimspector
  ]]
end
