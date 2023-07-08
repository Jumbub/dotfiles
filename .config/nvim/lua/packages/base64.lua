return {
  "christianrondeau/vim-base64",
  config = function()
    vim.api.nvim_set_keymap("v", "<leader>64", ",btoa", { silent = true })
    vim.api.nvim_set_keymap("v", "<leader>46", ",atob", { silent = true })
  end,
  keys = {
    { "<leader>64", mode = "v" },
    { "<leader>46", mode = "v" },
  },
}
