-- LSP Performance optimizations
vim.lsp.set_log_level("ERROR")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' }
}

-- Server configurations
local servers = {
    ts_ls = {},
    rust_analyzer = {},
    eslint = {},
    pylsp = {},
    ruby_lsp = {
        cmd = { vim.fn.expand("~/.local/bin/ruby-lsp-wrapper") },
        init_options = { formatter = "auto" },
    },
    lua_ls = {
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                diagnostics = { globals = {'vim'} },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
            },
        },
    },
}

-- LSP keymaps on attach
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local opts = { buffer = args.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    end,
})

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'ts_ls', 'rust_analyzer', 'eslint', 'ruby_lsp', 'pylsp' },
    automatic_enable = false,
})

-- Use the new nvim 0.11+ vim.lsp.config API
for server_name, config in pairs(servers) do
    vim.lsp.config[server_name] = {
        capabilities = capabilities,
        settings = config.settings or {},
        cmd = config.cmd,
        init_options = config.init_options,
    }
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
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lsp = '[LSP]',
                path = '[Path]',
                nvim_lua = '[Lua]',
            })[entry.source.name]
            return vim_item
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})
