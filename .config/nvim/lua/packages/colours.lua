return {
  {
    "rktjmp/lush.nvim",
  },
  {
    name = "monokai",
    dir = "/home/jamie/.config/nvim/monokai",
    config = function()
      vim.cmd([[colorscheme monokai]])
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
}
