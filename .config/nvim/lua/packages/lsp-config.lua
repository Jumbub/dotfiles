return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
        keys = {
          {
            "gs",
            function()
              require("nvim-navbuddy").open()
            end,
          },
        },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.tsserver.setup({
        capabilities = capabilities,
        commands = {
          OrganizeImports = {
            function()
              local params = {
                command = "_typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(0) },
                title = "",
              }
              vim.lsp.buf.execute_command(params)
            end,
            description = "Organize Imports",
          },
        },
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = "/usr/bin/lua-language-server",
            },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = "Apply",
              userThirdParty = { "/home/jamie/repos/lualibs" },
            },
            telemetry = { enable = false },
          },
        },
      })

      lspconfig.ccls.setup({
        capabilities = capabilities,
      })

      lspconfig.wgsl_analyzer.setup({
        capabilities = capabilities,
      })
    end,
  },
}
