return {
  "dhruvasagar/vim-prosession",
  dependencies = { "tpope/vim-obsession" },
  lazy = false,
  init = function()
    vim.g.prosession_dir = os.getenv("HOME") .. "/workspaces/vim/"
  end,
  -- {
  -- "rmagatti/auto-session",
  -- lazy = false,
  -- opts = {},
  -- }
}