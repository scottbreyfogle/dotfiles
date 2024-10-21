return {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                python = { "ruff_format", "ruff_organize_imports" },
                javascript = { "prettier" },
                typescript = { "prettier" },
            }
        })

        local function Format()
            conform.format({ lsp_format = "fallback" })
        end

        vim.keymap.set('n', '<leader>f', Format, { desc = 'Run formatting' });

        local function set_autoformat(pattern)
            vim.api.nvim_create_autocmd('BufWritePre', {
                pattern = pattern,
                callback = Format
            });
        end

        set_autoformat("*.lua")
        set_autoformat("*.py")
        set_autoformat("*.ts")
    end
}
