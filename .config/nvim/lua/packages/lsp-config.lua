return {
  -- {
  --   "mason-org/mason.nvim",
  --   opts = {
  --     registries = {
  --       "github:mason-org/mason-registry",
  --       "github:Crashdummyy/mason-registry",
  --     },
  --     automatic_installation = true,
  --     ensure_installed = {
  --       "roslyn",
  --     },
  --   },
  -- },
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    opts = {},
  },
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