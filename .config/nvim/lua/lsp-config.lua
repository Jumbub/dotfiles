local onAttach = function(client, bufnr)
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                     {virtual_text = false})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local function organize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

local lspconfig = require('lspconfig')

lspconfig.tsserver.setup {
    on_attach = onAttach,
    capabilities = capabilities,
    commands = {
        OrganizeImports = {organize_imports, description = "Organize Imports"}
    }
}

lspconfig.ccls.setup {on_attach = onAttach}

lspconfig.rust_analyzer.setup {on_attach = onAttach}

lspconfig.pyright.setup {on_attach = onAttach}

lspconfig.metals.setup {on_attach = onAttach}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require'lspconfig'.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = '/usr/bin/lua-language-server'
            },
            diagnostics = {globals = {'vim'}},
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false
            },
            telemetry = {enable = false}
        }
    }
}

vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>',
                        {silent = true})
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>',
                        {silent = true})
vim.api.nvim_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>',
                        {silent = true})
vim.api.nvim_set_keymap('n', 'gh', "<cmd>lua vim.lsp.buf.hover()<CR>",
                        {silent = true})
vim.api.nvim_set_keymap('n', 'gH', "<cmd>lua vim.diagnostic.open_float()<CR>",
                        {silent = true})
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>',
                        {silent = true})
vim.api.nvim_set_keymap('n', 'gDD', '<cmd>lua vim.lsp.buf.declaration()<CR>',
                        {silent = true})
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>',
                        {silent = true})
vim.api.nvim_set_keymap('n', '<leader>f',
                        '<cmd>lua vim.lsp.buf.code_action()<CR>',
                        {silent = true})
vim.api.nvim_set_keymap('n', 'gS', '<cmd>lua vim.lsp.buf.document_symbol()<CR>',
                        {silent = true})
vim.api.nvim_set_keymap('n', 'gs',
                        '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>',
                        {silent = true})

local cmp = require 'cmp'
cmp.setup {
    snippet = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end},
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true,
                                                               true, true), 'n')
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true,
                                                               true, true), 'n')
            else
                fallback()
            end
        end
    },
    sources = {{name = 'nvim_lsp'}}
}

local infoSigns = {
    Error = "•",
    Warning = "•",
    Hint = "•",
    Information = "•"
}
local infoColors = {
    "LspDiagnosticsDefaultError", "LspDiagnosticsDefaultWarning",
    "LspDiagnosticsDefaultInformation", "LspDiagnosticsDefaultHint"
}

for type, icon in pairs(infoSigns) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = ""})
end

function PrintDiagnostics(opts, bufnr, line_nr, client_id)
    opts = opts or {}

    bufnr = bufnr or 0
    line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)

    local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr,
                                                                     line_nr,
                                                                     opts,
                                                                     client_id)
    if vim.tbl_isempty(line_diagnostics) then return end

    for _, diagnostic in ipairs(line_diagnostics) do
        local output = string.format("%s", diagnostic.message or "")
        if #output > 140 then
            output = string.sub(output, 0, 140) .. '...'
        end
        vim.api.nvim_echo({{output, infoColors[diagnostic.severity or 4]}},
                          false, {})
        break
    end
end
