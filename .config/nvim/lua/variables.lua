vim.o.clipboard = 'unnamed' -- Share clipboard with system
vim.o.inccommand = 'split' -- Show substitude command effects as you type
vim.o.number = true -- Show curernt line number
vim.o.relativenumber = true -- Use relative line numbers
vim.o.signcolumn = 'yes' -- Always display gutter (prevent git gutter from bouncing on save
vim.o.statusline = '%F  %h%m%r%=%(%l,%c%)' -- Status line text
vim.o.swapfile = false -- Don't bother using swap files
vim.o.termguicolors = true -- Use terminal colours
vim.o.undodir = '/home/jamie/.vim/undodir' -- Set undo history file
vim.o.undofile = true -- Persist undo history between sessions
-- vim.o.rtp = vim.o.rtp .. ',/home/jamie/.config/nvim/monokai' -- Load local colour scheme
vim.o.breakindent = true -- Maintain indentation when wrapping text
vim.o.updatetime = 300 -- Cursor hold events
vim.o.wrap = true -- Wrap preference
vim.o.cmdheight = 2 -- Avoid "hit enter" text
vim.o.completeopt = 'menuone,noselect' -- LSP related probably

vim.g.mapleader = ','
