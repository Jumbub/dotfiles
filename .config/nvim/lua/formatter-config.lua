local prettier = {
    function()
        return {
            exe = "prettierd",
            args = {vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
            stdin = true
        }
    end
}

local black = {
    function() return {exe = "black", args = {"-"}, stdin = true} end
}

local cargofmt = {
    function() return {exe = "rustfmt", args = {}, stdin = true} end
}

local luaFormat = {
    function() return {exe = "lua-format", args = {}, stdin = true} end
}

local clang = {
    function() return {exe = "clang-format", args = {}, stdin = true} end
}

local black = {
    function() return {exe = "black", args = {"-"}, stdin = true} end
}

require('formatter').setup({
    filetype = {
        typescriptreact = prettier,
        typescript = prettier,
        javascript = prettier,
        json = prettier,
        python = black,
        cpp = clang,
        rust = cargofmt,
        lua = luaFormat
    }
})

vim.cmd [[
  command! FF Format
]]

vim.cmd [[
  augroup wrapSometimesYo
    autocmd!
    autocmd BufWritePost *.lua,*.tsx,*.ts,*.rs,*.cpp,*.h,*.js FormatWrite
    autocmd FileType yaml setlocal wrap nowrap
  augroup END
]]
