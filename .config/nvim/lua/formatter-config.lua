local prettier = {
  function()
    return {
      exe = "prettierd",
      args = {vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
      stdin = true
    }
  end,
}

local cargofmt = {
  function()
    return {
      exe = "rustfmt",
      args = {},
      stdin = true
    }
  end,
}

local clang = {
  function()
    return {
      exe = "clang-format",
      args = {},
      stdin = true
    }
  end,
}

require('formatter').setup({
  filetype = {
     typescriptreact = prettier,
     typescript = prettier,
     cpp = clang,
     rust = cargofmt,
  }
})

vim.cmd [[
  command! FF Format
]]

vim.cmd [[
  augroup fmt
    autocmd!
    autocmd BufWritePost *.tsx,*.rs,*.cpp,*.h FormatWrite
  augroup END
]]
