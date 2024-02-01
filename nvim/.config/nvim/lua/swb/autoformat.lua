local function set_autoformat(pattern)
    vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = pattern,
        command = "Format",
    });
end

set_autoformat("*.lua")
set_autoformat("*.py")
set_autoformat("*.ts")
