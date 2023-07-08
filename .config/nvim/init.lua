require("variables")
require("lsp")
require("packages.lazy").setup({
  require("packages/formatters"),
  require("packages/sessions"),
  require("packages/colours"),
  require("packages/files")[1],
  require("packages/files")[2],
  require("packages/search")[1],
  require("packages/search")[2],
  require("packages/treesitter")[1],
  require("packages/lsp-config")[1],
  require("packages/lsp-config")[2],
  require("packages/scroll")[1],
  require("packages/base64"),
  "tpope/vim-abolish", -- Word modifications
  "tpope/vim-surround", -- Word wapping
  "wakatime/vim-wakatime", -- Track development time
  { "tpope/vim-commentary", keys = { { "gcc" } } }, -- Quick comments
  { "tpope/vim-fugitive", command = "Git" }, -- Git wrapper
})
