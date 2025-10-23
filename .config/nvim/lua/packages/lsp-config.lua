return {
  --{
  --  "seblyng/roslyn.nvim",
  --  ---@module 'roslyn.config'
  --  ---@type RoslynNvimConfig
  --  opts = {
  --    cmd = {
  --      "Microsoft.CodeAnalysis.LanguageServer",
  --      -- "--logLevel", -- this property is required by the server
  --      -- "Information",
  --      -- "--extensionLogDirectory", -- this property is required by the server
  --      -- vim.fs.joinpath(vim.uv.os_tmpdir(), "roslyn_ls/logs"),
  --    },
  --  },
  --},
  -- {
  --   "fatih/vim-go",
  --   tag = "v1.29",
  --   -- cmd = { "GoCoverage" },
  -- },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- vim.lsp.config("omnisharp", {
      --   capabilities = capabilities,
      -- })
      -- vim.lsp.enable({ "omnisharp" })
      vim.lsp.config("gopls", {
        capabilities = capabilities,
      })
      vim.lsp.enable({ "gopls" })
    end,
  },
}