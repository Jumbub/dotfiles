return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.tsserver.setup({})
    end,
  },
  { "folke/neodev.nvim", opts = {} },
}
