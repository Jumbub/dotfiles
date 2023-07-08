return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "RRethy/nvim-treesitter-textsubjects", "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        highlight = { enable = true },
        textsubjects = {
          enable = true,
          prev_selection = ",",
          keymaps = {
            ["."] = "textsubjects-smart",
            ["af"] = "textsubjects-container-outer",
            ["if"] = "textsubjects-container-inner",
          },
        },
      })
    end,
  },
  "nvim-treesitter/playground",
}
