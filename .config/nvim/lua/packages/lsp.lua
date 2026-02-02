return {
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
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("gopls", {
        capabilities = capabilities,
      })
      vim.lsp.enable({ "gopls" })

      -- vim.lsp.config("luals", {
      --   capabilities = capabilities,
      -- })
      -- vim.lsp.enable({ "luals" })
    end,
  },
}