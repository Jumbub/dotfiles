return {
  { "rktjmp/lush.nvim" }, -- My theme bootstrapper
  {
    name = "monokai",
    dir = os.getenv("HOME") .. "/.config/nvim/monokai",
    config = function()
      vim.cmd([[colorscheme monokai]])
    end,
  }, -- My theme
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  }, -- Inline colour highlighting
}
