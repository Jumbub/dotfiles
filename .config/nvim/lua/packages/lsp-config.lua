return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.tsserver.setup({
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

      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = "/usr/bin/lua-language-server",
            },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })
    end,
  },
  { "folke/neodev.nvim", opts = {} },
}
