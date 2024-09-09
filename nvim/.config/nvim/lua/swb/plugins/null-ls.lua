return {
    -- LSP Configuration & Plugins
    'nvimtools/none-ls.nvim',
    -- The latest version has problems resolving shellcheck and reorder_python_imports.
    commit = '912f81829e9ab4ee3d54c3ea5a304c264f0003bc',
    priority = 110,
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
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
