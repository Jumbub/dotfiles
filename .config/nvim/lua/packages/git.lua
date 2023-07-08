return {
  { "tpope/vim-fugitive", cmd = "Git", lazy = true }, -- Git wrapper
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require("gitsigns").setup()
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
