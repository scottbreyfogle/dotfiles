return {
    "mfussenegger/nvim-lint",
    opts = {},
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            bash = { "shellcheck" },
            python = { "ruff" },
            sh = { "shellcheck" },
            terraform = { "tflint" },
            yaml = { "yamllint", "actionlint" },
        }
        vim.api.nvim_create_autocmd({ "InsertLeave", "BufReadPost", "TextChanged" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end
}
