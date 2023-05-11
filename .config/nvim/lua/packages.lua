local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    'christianrondeau/vim-base64', -- Encoding base64 strings
    'dhruvasagar/vim-open-url', -- Open URL in browser
    'editorconfig/editorconfig-vim', -- Formatting config
    'junegunn/fzf', -- Install fzf
    'junegunn/fzf.vim', -- Install fzf for vim
    'mhartington/formatter.nvim', -- Auto formatter
    'scrooloose/nerdtree', -- Directory tree
    'tpope/vim-abolish', -- Word modifications
    'tpope/vim-commentary', -- Quick comments
    'tpope/vim-eunuch', -- File helpers
    'tpope/vim-fugitive', -- Git wrapper
    'tpope/vim-surround', -- Word wapping
    'wakatime/vim-wakatime', -- Track development time
    {'dhruvasagar/vim-prosession', dependencies = {'tpope/vim-obsession'}}, -- Better session management
    {'nvim-telescope/telescope.nvim', dependencies = {'nvim-lua/plenary.nvim'}}, -- I think this is a dependency of another plugin

    -- Languages
    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function() require("trouble").setup {} end
    }, -- Diagnostics in window
    'hrsh7th/cmp-nvim-lsp', -- Autocomplete linker to LSP
    'hrsh7th/cmp-vsnip', -- Autocomplete linker to snippets
    'hrsh7th/nvim-cmp', -- Autocomplete tool
    'hrsh7th/vim-vsnip', -- Snippet tool (primarily used as auto-complete helper)
    'neovim/nvim-lspconfig', -- Configs
    -- 'nvim-treesitter/nvim-treesitter-textobjects', -- Extra language information
    -- 'nvim-treesitter/playground', -- TS playground
    {'nvim-treesitter/nvim-treesitter'}, -- Language parser
    -- 'puremourning/vimspector', -- Debugger
    -- 'metakirby5/codi.vim', -- Code scratchpad
    -- Visuals
    'Xuyuanp/scrollbar.nvim', -- Scroll bar
    'karb94/neoscroll.nvim', -- Smooth scroll
    -- 'norcalli/nvim-colorizer.lua', -- Highlight colour codes
    'tanvirtin/monokai.nvim', -- Colour scheme
    'rktjmp/lush.nvim', -- Colour scheme helper
    'lukas-reineke/indent-blankline.nvim', -- Indent guides
    {'lewis6991/gitsigns.nvim', dependencies = {'nvim-lua/plenary.nvim'}} -- Git signs
});

vim.g.prosession_dir = '/home/jamie/workspaces/vim/' -- Set the directory to create prosessions
vim.g.NERDTreeQuitOnOpen = true -- Close tree on opening a file
vim.g.NERDTreeWinSize = 60 -- Size of frame
vim.g.NERDTreeMinimalUI = true -- Remove boomarks and help text
vim.g.NERDTreeMinimalMenu = true -- Single line modifiers
vim.g['codi#interpreters'] = { -- Setup REPL commands for Codi
    javascript = {bin = 'node'},
    typescript = {bin = 'ts-node'}
}
-- Telescope
require'telescope'.setup()

-- LSP
require'nvim-treesitter.configs'.setup {
    ensure_installed = 'all',
    highlight = {enable = true}
};
local parser_config = require'nvim-treesitter.parsers'.get_parser_configs()
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
    ['zb'] = {'zb', {'50'}}
})
require('gitsigns').setup {
    signs = {
        add = {hl = 'DiffAdd', text = '+'},
        change = {hl = 'DiffChange', text = '~'},
        delete = {hl = 'DiffDelete', text = '_'},
        topdelete = {hl = 'DiffDelete', text = '‾'},
        changedelete = {hl = 'DiffDelete', text = '~'}
    }
}

require("indent_blankline").setup {
    -- char_highlight_list = {"IndentBlanklineIndent1", "IndentBlanklineIndent2"}
}

vim.g.scrollbar_right_offset = 0
vim.g.scrollbar_shape = {head = "█", body = "█", tail = "█"}
vim.g.scrollbar_highlight = {
    head = "ShadyDark",
    body = "ShadyDark",
    tail = "ShadyDark"
}
vim.cmd [[
  augroup ScrollbarInit
    autocmd!
    autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
    autocmd WinEnter * silent! lua require('scrollbar').show()
    autocmd WinLeave,BufLeave,BufWinLeave * silent! lua require('scrollbar').clear()
  augroup end
]]

require('trouble').setup {}
require('monokai').setup {}
-- require'colorizer'.setup()
