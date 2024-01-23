local function set_autoformat(pattern)
    vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = pattern,
        callback = function()
            vim.lsp.buf.format {
                async = false
            }
        end
    });
end

set_autoformat("*.lua")
set_autoformat("*.py")
set_autoformat("*.typescript")
