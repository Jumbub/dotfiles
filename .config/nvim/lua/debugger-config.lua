-- Debugging
-- vim.cmd [[
--   packadd! vimspector
-- ]]

vim.cmd [[
  function! GotoWindow(id)
      call win_gotoid(a:id)
  endfunction
]]

-- vim.api.nvim_set_keymap('n', '<leader>dl', ':call vimspector#Launch()<CR>', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dg', ':call vimspector#Continue()<CR>', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dq', ':call vimspector#Reset()<CR>', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dc', ':call GotoWindow(g:vimspector_session_windows.code)<CR>', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dt', ':call GotoWindow(g:vimspector_session_windows.tagpage)<CR>', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dv', ':call GotoWindow(g:vimspector_session_windows.variables)<CR>', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dw', ':call GotoWindow(g:vimspector_session_windows.watches)<CR>', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>ds', ':call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>do', ':call GotoWindow(g:vimspector_session_windows.output)<CR>', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dj', '<Plug>VimspectorStepOver', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dl', '<Plug>VimspectorStepInto', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dh', '<Plug>VimspectorStepOut', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dR', '<Plug>VimspectorRestart', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dd', '<Plug>VimspectorRunToCursor', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dbc', ':call vimspector#ClearBreakpoints()<CR>', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>db', '<Plug>VimspectorToggleBreakpoint', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dcb', '<Plug>VimspectorToggleConditionalBreakpoint', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>di', '<Plug>VimspectorBalloonEval', { silent = true })
-- vim.api.nvim_set_keymap('x', '<leader>di', '<Plug>VimspectorBalloonEval', { silent = true })
