require("variables")
require("keymaps")
require("packages.lazy")({
  require("packages/formatters"),
  require("packages/sessions"),
  require("packages/http"),
  require("packages/colours"),
  require("packages/files"),
  require("packages/search"),
  require("packages/scroll"),
  require("packages/treesitter"),
  require("packages/lsp"),
  require("packages/base64"),
  require("packages/git"),
  require("packages/completion"),
  require("packages/viewers"),
  require("packages/images"),
  "wakatime/vim-wakatime",
  "tpope/vim-surround", -- Word wapping
  {
    "tpope/vim-commentary", -- Code commenting
    config = function()
      vim.cmd([[autocmd FileType terraform setlocal commentstring=#\ %s]])
      vim.cmd([[autocmd FileType cpp setlocal commentstring=//\ %s]])
      vim.cmd([[autocmd FileType c setlocal commentstring=//\ %s]])
      vim.cmd([[autocmd FileType h setlocal commentstring=//\ %s]])
    end,
  },
})
