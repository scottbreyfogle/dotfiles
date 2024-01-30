return {
    -- LSP Configuration & Plugins
    'nvimtools/none-ls.nvim',
    priority = 110,
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
            sources = {
                -- JS formatter
                null_ls.builtins.formatting.prettier,

                -- GH Actions linter
                null_ls.builtins.diagnostics.actionlint,
                null_ls.builtins.diagnostics.ansiblelint,
                -- Bash/shell linter
                null_ls.builtins.code_actions.shellcheck,

                -- Python
                -- General formatter
                null_ls.builtins.formatting.black,
                -- TODO: which linters are good?
                -- null_ls.builtins.diagnostics.pylint,
                -- null_ls.builtins.diagnostics.pyproject_flake8,
                null_ls.builtins.formatting.reorder_python_imports.with({
                    command = "reorder-python-imports",
                    args = { "-", "--exit-zero-even-if-changed", "--unclassifiable-application-module=descript" },
                    to_stdin = true,
                }),
            }
        })
    end
}
