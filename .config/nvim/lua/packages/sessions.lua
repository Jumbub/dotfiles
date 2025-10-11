return {
  "dhruvasagar/vim-prosession",
  dependencies = { "tpope/vim-obsession", "junegunn/fzf.vim" },
  lazy = false,
  init = function()
    vim.g.prosession_dir = os.getenv("HOME") .. "/workspaces/vim/"
  end,
  config = function()
    vim.api.nvim_set_keymap(
      "n",
      "<leader>p",
      ":call fzf#run({'source': 'find ~/workspaces/vim/*', 'sink': 'Prosession', 'down': '10', 'options': '--tiebreak=end'})<CR>",
      { silent = true }
    )
  end,
}
