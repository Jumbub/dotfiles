return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "RRethy/nvim-treesitter-textsubjects", "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      -- require("nvim-treesitter.configs").setup({
      --   ensure_installed = "all",
      --   highlight = { enable = true },
      --   textsubjects = {
      --     enable = false,
      --     prev_selection = "<C-a><C-f>",
      --     keymaps = {
      --       ["AF"] = "textsubjects-smart",
      --       ["af"] = "textsubjects-container-outer",
      --       ["if"] = "textsubjects-container-inner",
      --     },
      --   }, -- },
      -- })
    end,
  }, -- Language parser
  "nvim-treesitter/playground", -- TS playground
}
