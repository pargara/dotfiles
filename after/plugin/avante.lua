local ok, avante = pcall(require, "avante")
if not ok then
    return
end

local root = require("avante.utils.root")
if not root._pargara_invalid_buf_guard then
    root._pargara_invalid_buf_guard = true
    local root_get = root.get

    root.get = function(opts)
        if opts and opts.buf and opts.buf ~= 0 and not vim.api.nvim_buf_is_valid(opts.buf) then
            opts = vim.tbl_extend("force", opts, { buf = vim.api.nvim_get_current_buf() })
        end

        local ok_root, project_root = pcall(root_get, opts)
        if ok_root then
            return project_root
        end

        if tostring(project_root):match("Invalid buffer id") then
            return vim.uv.cwd() or vim.fn.getcwd()
        end

        error(project_root, 0)
    end
end

avante.setup({
    provider = "claude-code",
    mode = "agentic",
    instructions_file = "avante.md",
    input = {
        provider = "snacks",
    },
    selector = {
        provider = "telescope",
    },
    acp_providers = {
        ["claude-code"] = {
            command = "claude-agent-acp",
            args = {},
            env = {
                NODE_NO_WARNINGS = "1",
                ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY"),
                ANTHROPIC_BASE_URL = os.getenv("ANTHROPIC_BASE_URL"),
                ACP_PATH_TO_CLAUDE_CODE_EXECUTABLE = vim.fn.exepath("claude"),
                ACP_PERMISSION_MODE = os.getenv("ACP_PERMISSION_MODE") or "bypassPermissions",
            },
        },
    },
})

vim.keymap.set("n", "<leader>aa", "<cmd>AvanteAsk<cr>", { desc = "Avante ask" })
vim.keymap.set("v", "<leader>aa", "<cmd>AvanteAsk<cr>", { desc = "Avante ask selection" })
vim.keymap.set("n", "<leader>at", "<cmd>AvanteToggle<cr>", { desc = "Toggle Avante" })
