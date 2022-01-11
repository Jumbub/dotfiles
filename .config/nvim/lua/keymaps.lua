  -- On hover, show diagnostics in the echo view
  -- vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]

  -- When NERDtree is the last window, close vim
  vim.cmd [[ autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif ]]

  -- Manual format
  vim.cmd [[
    command! FF Format
  ]]

  -- Format on save
  vim.cmd [[
    augroup fmt
      autocmd!
      autocmd BufWritePost *.tsx,*.rs FormatWrite
    augroup END
  ]]

  -- Setup VimSpector debugger
  vim.cmd [[
    au VimEnter * :packadd! vimspector
  ]]

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
