-- On hover, show diagnostics in the echo view
-- vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]

-- When NERDtree is the last window, close vim
vim.cmd [[ autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif ]]

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

-- Base64 encoding
vim.api.nvim_set_keymap('v', ',64', ',btoa', {silent=true})
vim.api.nvim_set_keymap('v', ',46', ',atob', {silent=true})
