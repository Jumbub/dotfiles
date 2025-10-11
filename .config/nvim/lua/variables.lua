vim.g.mapleader = ","

vim.opt.breakindent = true -- Maintain indentation when wrapping text
vim.opt.cmdheight = 2 -- Avoid "hit enter" text
vim.opt.inccommand = "split" -- Show substitude command effects as you type
vim.opt.laststatus = 3 -- Global status line
vim.opt.number = true -- Show absolute line number at cursor
vim.opt.relativenumber = true -- Use relative line numbers
vim.opt.signcolumn = "yes" -- Always display gutter (prevent git gutter from bouncing on save
vim.opt.statusline = "%F  %h%m%r%=%(%l,%c%)" -- Status line text
vim.opt.swapfile = false -- Don't bother using swap files
vim.opt.termguicolors = true -- Use terminal colours
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Set undo history file
vim.opt.undofile = true -- Persist undo history between sessions
vim.opt.updatetime = 300 -- Cursor hold events
vim.opt.wrap = false -- Wrap preference
vim.opt.shiftwidth = 2 -- Wrap preference

vim.schedule(function() -- delay slow options
  vim.opt.clipboard = "unnamedplus" -- Share clipboard with system
end)
