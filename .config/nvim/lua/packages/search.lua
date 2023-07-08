return {
  {
    "junegunn/fzf",
  },
  {
    "junegunn/fzf.vim",
    config = function() end,
    keys = {
      {
        "<C-p>",
        "<cmd>Files<cr>",
      },
      {
        "<C-:>",
        "<cmd>History<cr>",
      },
    },
  },
}
