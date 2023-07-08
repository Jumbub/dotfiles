require('dap/typescript')

local dap = require('dap')
local dapui = require('dapui')

dapui.setup({})

-- dap.listeners.after.event_initialized["dapui_config"] =
--     function() dapui.open() end
-- dap.listeners.before.event_terminated["dapui_config"] =
--     function() dapui.close() end
-- dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

vim.keymap.set('n', '<leader>du', dapui.toggle)

vim.keymap.set('n', '<leader>dd', dap.run_last)
vim.keymap.set('n', '<leader>dc', dap.continue)
vim.keymap.set('n', '<leader>dcc', dap.run_to_cursor)
vim.keymap.set('n', '<leader>df', dap.focus_frame)
vim.keymap.set('n', '<leader>dt', dap.terminate)
vim.keymap.set('n', '<leader>dcb', dap.clear_breakpoints)
vim.keymap.set('n', '<leader>dlb', dap.list_breakpoints)
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)

vim.keymap.set('n', '<leader>duu', dap.up)
vim.keymap.set('n', '<leader>ddd', dap.down)

-- vim.keymap.set('n', '<leader>dh', dap.step_back)
-- vim.keymap.set('n', '<leader>dl', dap.step_next)
-- vim.keymap.set('n', '<leader>dj', dap.toggle_breakpoint)
-- vim.keymap.set('n', '<leader>dk', dap.step_into)

-- vim.keymap.set('n', '<leader>r', dap.repl.toggle())

-- dap.session
-- dap.sessions
-- dap.status
