-- https://strdr4605.com/typescript-errors-into-vim-quickfix
vim.cmd([[
  augroup strdr4605
    autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=npx\ tsc
  augroup END
]])

-- Populates quickfix list with errors
vim.keymap.set("n", "gE", "<cmd>make<cr>", { silent = true })
