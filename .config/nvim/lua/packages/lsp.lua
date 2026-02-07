return {
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

      vim.lsp.config("roslyn_ls", {
        capabilities = capabilities,
      })
      vim.lsp.enable({ "roslyn_ls" })
    end,
  },
}
