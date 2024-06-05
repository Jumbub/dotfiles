return {
  "mhartington/formatter.nvim",
  event = "BufWritePre",
  cmd = "FF",
  config = function()
    local prettier = {
      function()
        return {
          exe = "prettierd",
          args = { vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
          stdin = true,
        }
      end,
    }

    local cargofmt = {
      function()
        return { exe = "rustfmt", args = {}, stdin = true }
      end,
    }

    local stylua = {
      function()
        return { exe = "stylua", args = { "-" }, stdin = true }
      end,
    }

    local clang = {
      function()
        return { exe = "clang-format", args = {}, stdin = true }
      end,
    }

    local black = {
      function()
        return { exe = "black", args = { "-" }, stdin = true }
      end,
    }

    local terraformfmt = {
      function()
        return { exe = "terraform", args = { "fmt", "-" }, stdin = true }
      end,
    }

    require("formatter").setup({
      filetype = {
        html = prettier,
        svg = prettier,
        css = prettier,
        typescriptreact = prettier,
        typescript = prettier,
        javascript = prettier,
        json = prettier,
        python = black,
        cpp = clang,
        rust = cargofmt,
        lua = stylua,
        terraform = terraformfmt,
      },
    })

    vim.api.nvim_create_user_command("FF", "Format", {})
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      pattern = { "*.lua", "*.tsx", "*.ts", "*.rs", "*.cpp", "*.h", "*.js", "*.css", "*.html", "*.tf" },
      command = "FormatWrite",
      group = vim.api.nvim_create_augroup("FormatterGroup", {}),
    })
  end,
}
