return function()
  vim.o.hidden = true -- TextEdit might fail if hidden is not vim.o.
  vim.o.nobackup = true -- Some servers have issues with backup files, see #649.
  vim.o.nowritebackup = true
  vim.o.updatetime = 300  -- Give more space for displaying messages.
  vim.o.shortmess += 'c' -- Don't pass messages to |ins-completion-menu|.
end
