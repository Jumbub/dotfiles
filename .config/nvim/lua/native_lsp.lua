return function()
  vim.o.completeopt = 'menuone,noselect'

  local nvim_lsp = require('lspconfig')

  local onAttach = function(client, bufnr)
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false
        }
    )
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local function organize_imports()
    local params = {
      command = "_typescript.organizeImports",
      arguments = {vim.api.nvim_buf_get_name(0)},
      title = ""
    }
    vim.lsp.buf.execute_command(params)
  end

  require'lspconfig'.tsserver.setup {
    on_attach = onAttach,
    capabilities = capabilities,
    commands = {
      OrganizeImports = {
        organize_imports,
        description = "Organize Imports"
      }
    }
  }


  vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gh', "<cmd>lua vim.lsp.buf.hover()<CR>", {silent=true})
  vim.api.nvim_set_keymap('n', 'gH', "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border='single'})<CR>", {silent=true})
  vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gDD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.code_action()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gS', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', {silent=true})
  vim.api.nvim_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', {silent=true})

  require('lspfuzzy').setup { methods = {'textDocument/codeAction'} }

  local cmp = require 'cmp'
  cmp.setup {
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-u>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
        else
          fallback()
        end
      end,
    },
    sources = {
      { name = 'nvim_lsp' },
    },
  }

  local signs = { Error = "x", Warning = "i", Hint = "i", Information = "i" }
  local infoColors = { "LspDiagnosticsDefaultError", "LspDiagnosticsDefaultWarning", "LspDiagnosticsDefaultInformation", "LspDiagnosticsDefaultHint" }

  for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

function PrintDiagnostics(opts, bufnr, line_nr, client_id)
  opts = opts or {}

  bufnr = bufnr or 0
  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)

  local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
  if vim.tbl_isempty(line_diagnostics) then return end

  for _, diagnostic in ipairs(line_diagnostics) do
    vim.api.nvim_echo({{
      string.format("%s %s", diagnostic.message or "", diagnostic.severity or ""),
      infoColors[diagnostic.severity or 4]
    }}, false, {})
    break
  end
end

vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]
end;
