return {
    -- LSP Configuration & Plugins
    'jose-elias-alvarez/null-ls.nvim',
    priority = 110,
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
            sources = {
                -- JS linter
                null_ls.builtins.formatting.prettier,
                -- GH Actions linter
                null_ls.builtins.diagnostics.actionlint,
                null_ls.builtins.diagnostics.ansiblelint,
                -- Bash/shell linter
                null_ls.builtins.code_actions.shellcheck,
                -- Bash/shell linter

                -- Python
                -- Import sorts
                null_ls.builtins.formatting.isort,
                -- General formatter
                null_ls.builtins.formatting.black,
                -- TODO: which linters are good?
                -- null_ls.builtins.diagnostics.pylint,
                -- null_ls.builtins.diagnostics.pyproject_flake8,
            }
        })
    end
}
