require("variables")
require("lsp")
require("keymaps")
require("make")
require("packages.lazy")({
  require("packages/formatters"),
  require("packages/sessions"),
  require("packages/colours"),
  require("packages/files"),
  require("packages/search"),
  require("packages/scroll"),
  require("packages/treesitter"),
  require("packages/lsp-config"),
  require("packages/dap"),
  require("packages/base64"),
  require("packages/git"),
  require("packages/cursor"),
  require("packages/completion"),
  "wakatime/vim-wakatime",
  "tpope/vim-surround", -- Word wapping
  "tpope/vim-commentary", -- Code commenting
  "tpope/vim-commentary", -- Code commenting
  "metakirby5/codi.vim", -- Scratch pad
})
