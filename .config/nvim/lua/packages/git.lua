return {
  { "tpope/vim-fugitive", cmd = "Git", lazy = true }, -- Git wrapper
  { "lewis6991/gitsigns.nvim", opts = {} }, -- Git in gutter
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    lazy = true,
    config = function()
      require("gitlinker").setup({
        router = {
          browse = {
            ["^github%.eagleview%.com"] = require("gitlinker.routers").github_browse,
          },
          blame = {
            ["^github%.eagleview%.com"] = require("gitlinker.routers").github_blame,
          },
        },
      })
    end,
  },
}
