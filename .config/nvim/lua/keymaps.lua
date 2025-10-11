-- Git traversal
vim.keymap.set("n", "gm", "<cmd>cexpr system('git jump --stdout diff')<cr><cmd>copen<cr>")

-- Redo alias
vim.keymap.set("n", "U", ":redo<CR>", { silent = true, noremap = true })

-- Save without auto commands
vim.keymap.set("n", "<C-s>", ":noautocmd up<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", "s", {})

-- Buffer search
vim.keymap.set("n", "/", "/\\c", {})
vim.keymap.set("n", "?", "?\\c", {})
vim.keymap.set("v", "/", "/\\c", {})
vim.keymap.set("v", "?", "?\\c", {})

-- Change selection
vim.keymap.set("v", "<leader>c", "*Ncgn", { remap = true })

-- Quickfix navigation
vim.keymap.set("n", "<C-k>", ":cp<CR>zz", {})
vim.keymap.set("n", "<C-j>", ":cn<CR>zz", {})
vim.keymap.set("n", "<C-h>", ":cclose<CR>", {})
vim.keymap.set("n", "<C-l>", ":copen<CR>", {})

-- Traverse wrapped lines
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- UUID
vim.keymap.set("n", "<leader>uu", "i<C-r>=system(\"uuidgen | tr -d '\\n'\")<CR><ESC>", { silent = true })
vim.keymap.set("v", "<leader>uu", "c<C-r>=system(\"uuidgen | tr -d '\\n'\")<CR><ESC>", { silent = true })

-- Diagnostics
vim.keymap.set("n", "gH", vim.diagnostic.open_float)
vim.keymap.set("n", "<C-e>", vim.diagnostic.goto_next)
vim.keymap.set("n", "ge", vim.diagnostic.setqflist)

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
