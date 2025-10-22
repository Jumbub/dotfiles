return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "RRethy/nvim-treesitter-textsubjects", "nvim-treesitter/nvim-treesitter-textobjects" },
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup({
        sync_install = true,
        auto_install = false,
        ensure_installed = { "typescript", "tsx", "c", "cpp", "c_sharp", "yaml", "json", "go", "gomod", "gosum" },
        ignore_install = {},
        highlight = { enable = true },
        modules = {},
        textsubjects = {
          enable = true,
          prev_selection = ",",
          keymaps = {
            ["."] = "textsubjects-smart",
          },
        },
      })
    end,
  },
}
