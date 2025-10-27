vim.g.mapleader = ","

vim.o.breakindent = true -- Maintain indentation when wrapping text
vim.o.cmdheight = 2 -- Avoid "hit enter" text
vim.o.inccommand = "split" -- Show substitude command effects as you type
vim.o.laststatus = 3 -- Global status line
vim.o.number = true -- Show absolute line number at cursor
vim.o.relativenumber = true -- Use relative line numbers
vim.o.signcolumn = "yes" -- Always display gutter (prevent git gutter from bouncing on save
vim.o.statusline = "%F  %h%m%r%=%(%l,%c%)" -- Status line text
vim.o.swapfile = false -- Don't bother using swap files
vim.o.termguicolors = true -- Use terminal colours
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Set undo history file
vim.o.undofile = true -- Persist undo history between sessions
vim.o.updatetime = 300 -- Cursor hold events
vim.o.wrap = false -- Wrap preference
vim.o.shiftwidth = 2 -- Wrap preference

vim.schedule(function() -- delay slow options
  vim.o.clipboard = "unnamedplus" -- Share clipboard with system
  vim.g.clipboard = "osc52"
end)