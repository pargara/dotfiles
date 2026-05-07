local ok, snacks = pcall(require, "snacks")
if not ok then
    return
end

snacks.setup({
    bigfile = { enabled = true },
    explorer = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
    quickfile = { enabled = true },
})

snacks.picker.setup()
snacks.input.enable()
