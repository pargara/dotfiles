local lsp_zero = require('lsp-zero')

-- LSP Performance optimizations
vim.lsp.set_log_level("ERROR")  -- Reduce logging overhead

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Optimize capabilities for better performance
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' }
}

local servers = {
    ts_ls = {},
    rust_analyzer = {},
    eslint = {},
    pyre = {},
    pylsp = {},
    -- Use only ruby_lsp for Ruby (modern, fast, official LSP)
    -- Removed: solargraph (slower), sorbet (type checker, conflicts), rubocop (linter, not LSP)
    ruby_lsp = {
        init_options = {
            enabledFeatures = {
                "documentHighlights",
                "documentSymbols",
                "foldingRanges",
                "selectionRanges",
                "semanticHighlighting",
                "formatting",
                "codeActions",
            },
            formatter = "auto",  -- Use rubocop if available, otherwise syntax_tree
        },
    },
    lua_ls = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

lsp_zero.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'ts_ls', 'rust_analyzer', 'eslint', 'ruby_lsp', "pyre", "pylsp" },
    automatic_enable = false,
})

-- Use the new nvim 0.11+ vim.lsp.config API instead of deprecated lspconfig
for server_name, server_settings in pairs(servers) do
    vim.lsp.config[server_name] = {
        capabilities = capabilities,
        on_attach = lsp_zero.on_attach,
        settings = server_settings,
        filetypes = server_settings.filetypes,
    }
    -- Enable the LSP server
    vim.lsp.enable(server_name)
end

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    -- Performance optimizations
    performance = {
        debounce = 60,           -- Reduce from default 60ms (already optimal)
        throttle = 30,           -- Reduce from default 30ms (already optimal)
        fetching_timeout = 200,  -- Reduce from default 500ms for faster results
        max_view_entries = 50,   -- Limit visible entries for better performance
    },
    sources = {
        {name = 'nvim_lsp', max_item_count = 50},  -- Limit LSP completions
        {name = 'path', max_item_count = 20},
        {name = 'nvim_lua', max_item_count = 20},
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})
