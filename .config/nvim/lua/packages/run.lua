return {
  {
    "leoluz/nvim-dap-go",
    opts = {
      dap_configurations = {
        {
          type = "go",
          name = "attach dlv [port=38697]",
          mode = "remote",
          request = "attach",
          port = 38697,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "igorlfs/nvim-dap-view",
    },
    keys = {},
    config = function()
      local dap = require("dap")
      local netcoredbg_adapter = {
        type = "executable",
        command = "netcoredbg",
        args = { "--interpreter=vscode" },
      }
      dap.adapters.netcoredbg = netcoredbg_adapter
      dap.adapters.coreclr = netcoredbg_adapter
      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          -- program = function()
          --   -- return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/src/", "file")
          --   return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/net8.0/", "file")
          -- end,
          -- justMyCode = false,
          -- stopAtEntry = false,
          -- -- program = function()
          -- --   -- todo: request input from ui
          -- --   return "/path/to/your.dll"
          -- -- end,
          -- env = {
          --   ASPNETCORE_ENVIRONMENT = function()
          --     -- todo: request input from ui
          --     return "Development"
          --   end,
          --   ASPNETCORE_URLS = function()
          --     -- todo: request input from ui
          --     return "http://localhost:5050"
          --   end,
          -- },
          -- cwd = function()
          --   -- todo: request input from ui
          --   return vim.fn.getcwd()
          -- end,
        },
      }

      vim.keymap.set("n", ",du", require("dap-view").toggle)
      vim.keymap.set("n", ",dt", require("dap").terminate)
      vim.keymap.set("n", ",db", require("dap").toggle_breakpoint)
      vim.keymap.set("n", ",dl", require("dap").list_breakpoints)
      vim.keymap.set("n", ",dc", require("dap").continue)
      vim.keymap.set("n", "<down>", require("dap").step_over)
      vim.keymap.set("n", "<right>", require("dap").step_into)
      vim.keymap.set("n", "<left>", require("dap").step_out)
      vim.keymap.set("n", "<up>", require("dap").step_back)
      dap.listeners.after.event_initialized["dapui_config"] = require("dap-view").open
      dap.listeners.before.event_terminated["dapui_config"] = require("dap-view").close
      dap.listeners.before.event_exited["dapui_config"] = require("dap-view").close
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- langs
      "fredrikaverpil/neotest-golang",
      "nsidorenco/neotest-vstest",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-golang")({}),
          require("neotest-vstest")({}),
        },
      })
      vim.keymap.set("n", "<leader>tt", require("neotest").run.run)
      vim.keymap.set("n", "<leader>td", function()
        require("neotest").run.run({ strategy = "dap" })
      end)
      vim.keymap.set("n", "<leader>tw", require("neotest").watch.watch)
      vim.keymap.set("n", "<leader>tu", require("neotest").summary.toggle)
    end,
  },
}
