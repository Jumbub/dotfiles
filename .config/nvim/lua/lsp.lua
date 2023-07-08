vim.diagnostic.config({
  virtual_text = false,
})
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts = opts or {}
  opts.virtual_text = false
  opts.border = opts.border
    or {
      { "🭽", "FloatBorder" },
      { "▔", "FloatBorder" },
      { "🭾", "FloatBorder" },
      { "▕", "FloatBorder" },
      { "🭿", "FloatBorder" },
      { "▁", "FloatBorder" },
      { "🭼", "FloatBorder" },
      { "▏", "FloatBorder" },
    }
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.keymap.set("i", "<c-space>", "<c-x><c-o>", {})
vim.keymap.set("n", "gH", vim.diagnostic.open_float)
vim.keymap.set("n", "<C-e>", vim.diagnostic.goto_next)
vim.keymap.set("n", "ge", vim.diagnostic.setqflist)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gDD", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  end,
})
