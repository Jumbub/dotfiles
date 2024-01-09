-- Git traversal
vim.keymap.set("n", "gm", "<cmd>cexpr system('git jump --stdout diff')<cr><cmd>copen<cr>")

-- Undo alias
vim.keymap.set("n", "U", ":redo<CR>", { silent = true, noremap = true })

-- Suss
vim.keymap.set("n", "<C-s>", ":w<CR>", {})
vim.keymap.set("n", "<C-q>", ":q<CR>", {})

-- Buffer search
vim.keymap.set("n", "/", "/\\c", {})
vim.keymap.set("n", "?", "?\\c", {})
vim.keymap.set("v", "/", "/\\c", {})
vim.keymap.set("v", "?", "?\\c", {})

-- Change selection
vim.keymap.set("v", "<leader>c", "*Ncgn", { remap = true })

-- Navigation
vim.keymap.set("n", "<C-o>", "<C-o>zz", {})
vim.keymap.set("n", "<C-i>", "<C-i>zz", {})

-- Quickfix navigation
vim.keymap.set("n", "<C-k>", ":cp<CR>zz", {})
vim.keymap.set("n", "<C-j>", ":cn<CR>zz", {})
vim.keymap.set("n", "<C-h>", ":cclose<CR>", {})
vim.keymap.set("n", "<C-l>", ":copen<CR>", {})

-- Traverse wrapped lines
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- UUID
vim.keymap.set("n", "<leader>uu", 'i<C-r>=system("uuid")<CR><ESC>', { silent = true })
vim.keymap.set("v", "<leader>uu", 'c<C-r>=system("uuid")<CR><ESC>', { silent = true })

vim.keymap.set("n", "<C-r>", ":!lua '%'<CR>")
