return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("packages/dap/js-debug")

      local dap = require("dap")

      dap.listeners.after.event_initialized["dapui_config"] = function()
        require("dap").set_exception_breakpoints({ "throw", "Error", "error", "uncaught", "raised" })
        require("dap").defaults.fallback.exception_breakpoints = { "throw", "Error", "error", "uncaught", "raised" }
      end

      vim.keymap.set("n", "<leader>dc", dap.continue, {})
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
      vim.keymap.set("n", "<leader>dB", dap.list_breakpoints, {})
      vim.keymap.set("n", "<leader>dt", dap.terminate, {})
      vim.keymap.set("n", "<leader>dr", dap.restart, {})

      vim.keymap.set("n", "<M-o>", dap.up, {})
      vim.keymap.set("n", "<M-i>", dap.down, {})
      vim.keymap.set("n", "<M-k>", dap.step_back, {})
      vim.keymap.set("n", "<M-j>", dap.step_over, {})
      vim.keymap.set("n", "<M-l>", dap.step_into, {})
      vim.keymap.set("n", "<M-h>", dap.step_out, {})
    end,
    keys = {
      "<leader>dc",
      "<leader>db",
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      dapui.setup({})

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      vim.keymap.set("v", "gh", dapui.eval, {})
      vim.keymap.set("n", "<leader>du", dapui.toggle)
    end,
  },
}
