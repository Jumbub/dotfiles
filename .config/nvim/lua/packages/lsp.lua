return {
  -- {
  --   "maxandron/goplements.nvim",
  --   ft = "go",
  --   opts = {
  --     highlight = "comment",
  --   },
  --   cmd = "GoplementsEnable",
  -- },
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

      vim.lsp.config("buf_ls", {
        capabilities = capabilities,
      })
      vim.lsp.enable({ "buf_ls" })

      vim.lsp.config("roslyn_ls", {
        capabilities = capabilities,
      })
      vim.lsp.enable({ "roslyn_ls" })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          client.server_capabilities.semanticTokensProvider = nil
        end,
      })
    end,
  },
}
