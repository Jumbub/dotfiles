-- Undo alias
vim.api.nvim_set_keymap("n", "U", ":redo<CR>", { silent = true, noremap = true })

-- Suss
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", {})
vim.api.nvim_set_keymap("n", "<C-q>", ":q<CR>", {})

-- Buffer search
vim.api.nvim_set_keymap("n", "/", "/\\c", {})
vim.api.nvim_set_keymap("n", "?", "?\\c", {})
vim.api.nvim_set_keymap("v", "/", "/\\c", {})
vim.api.nvim_set_keymap("v", "?", "?\\c", {})

-- Workspace search
vim.api.nvim_set_keymap("v", "<leader>j", '"sy:Rg <C-r>s<CR>', {})

-- Change selection
vim.api.nvim_set_keymap("v", "<leader>c", "*Ncgn", {})

-- Quickfix navigation
vim.api.nvim_set_keymap("n", "<C-k>", ":cp<CR>", {})
vim.api.nvim_set_keymap("n", "<C-j>", ":cn<CR>", {})
vim.api.nvim_set_keymap("n", "<C-h>", ":cclose<CR>", {})
vim.api.nvim_set_keymap("n", "<C-l>", ":copen<CR>", {})

-- Traverse wrapped lines
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- UUID
vim.api.nvim_set_keymap("n", "<leader>uu", 'i<C-r>=system("uuid")<CR><ESC>', { silent = true })
vim.api.nvim_set_keymap("v", "<leader>uu", 'c<C-r>=system("uuid")<CR><ESC>', { silent = true })
