-- cd ~/.DAP/vscode-js-debug
local dap = require('dap')
-- require("dap-vscode-js").setup({
--     node_path = "node",
--     debugger_path = os.getenv("HOME") .. "/.local/js-debug/src",
--     adapters = {
--         "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal",
--         "pwa-extensionHost"
--     }
-- })

require("dap").adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",
        -- 💀 Make sure to update this path to point to your installation
        args = {"/home/jamie/.local/js-debug/src/dapDebugServer.js", "${port}"}
    }
}

local exts = {
    "javascript", "typescript", "javascriptreact", "typescriptreact",
    -- using pwa-chrome
    "vue", "svelte"
}

for i, ext in ipairs(exts) do
    dap.configurations[ext] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File (pwa-node)",
            cwd = vim.fn.getcwd(),
            args = {"${file}"},
            sourceMaps = true,
            protocol = "inspector"
        }, {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File (pwa-node with ts-node)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = {"--loader", "ts-node/esm"},
            runtimeExecutable = "node",
            args = {"${file}"},
            sourceMaps = true,
            protocol = "inspector",
            skipFiles = {"<node_internals>/**", "node_modules/**"},
            resolveSourceMapLocations = {
                "${workspaceFolder}/**", "!**/node_modules/**"
            }
        }, {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File (pwa-node with deno)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = {"run", "--inspect-brk", "--allow-all", "${file}"},
            runtimeExecutable = "deno",
            attachSimplePort = 9229
        }, {
            type = "pwa-node",
            request = "launch",
            name = "Launch Test Current File (pwa-node with jest)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = {"${workspaceFolder}/node_modules/.bin/jest"},
            runtimeExecutable = "node",
            args = {"${file}", "--coverage", "false"},
            rootPath = "${workspaceFolder}",
            sourceMaps = true,
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            skipFiles = {"<node_internals>/**", "node_modules/**"}
        }, {
            type = "pwa-node",
            request = "launch",
            name = "Launch Test Current File (pwa-node with vitest)",
            cwd = vim.fn.getcwd(),
            program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
            args = {"--inspect-brk", "--threads", "false", "run", "${file}"},
            autoAttachChildProcesses = true,
            smartStep = true,
            console = "integratedTerminal",
            skipFiles = {"<node_internals>/**", "node_modules/**"}
        }, {
            type = "pwa-node",
            request = "launch",
            name = "Launch Test Current File (pwa-node with deno)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = {"test", "--inspect-brk", "--allow-all", "${file}"},
            runtimeExecutable = "deno",
            smartStep = true,
            console = "integratedTerminal",
            attachSimplePort = 9229
        }, {
            type = "pwa-chrome",
            request = "attach",
            name = "Attach Program (pwa-chrome, select port)",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            port = function()
                return vim.fn.input("Select port: ", 9222)
            end,
            webRoot = "${workspaceFolder}"
        }, -- {
        --   type = "node2",
        --   request = "attach",
        --   name = "Attach Program (Node2)",
        --   processId = dap_utils.pick_process,
        -- },
        -- {
        --   type = "node2",
        --   request = "attach",
        --   name = "Attach Program (Node2 with ts-node)",
        --   cwd = vim.fn.getcwd(),
        --   sourceMaps = true,
        --   skipFiles = { "<node_internals>/**" },
        --   port = 9229,
        -- },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach Program (pwa-node, select pid)",
            cwd = vim.fn.getcwd(),
            processId = require('dap.utils').pick_process,
            skipFiles = {"<node_internals>/**"}
        }
    }
end
