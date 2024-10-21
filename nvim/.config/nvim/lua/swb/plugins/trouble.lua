return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        trouble = require("trouble")
        trouble.setup()
        vim.keymap.set("n", "<leader>t", function() trouble.toggle("diagnostics") end, { desc = '[T]rouble' })
        vim.keymap.set("n", "<leader>tq", function() trouble.toggle("quickfix") end,
            { desc = '[T]rouble [Q]uickfix' })
        vim.keymap.set("n", "<leader>tl", function() trouble.toggle("loclist") end, { desc = '[T]rouble [L]oclist' })
        vim.keymap.set("n", "gr", function() trouble.toggle("lsp_references") end,
            { desc = '[G]o to [R]eferences (trouble)' })
        vim.keymap.set("n", "[R", function() trouble.first({ skip_groups = true, jump = true }); end,
            { desc = 'First trouble entry' })
        vim.keymap.set("n", "[r", function() trouble.previous({ skip_groups = true, jump = true }); end,
            { desc = 'Last trouble entry' })
        vim.keymap.set("n", "]r", function() trouble.next({ skip_groups = true, jump = true }); end,
            { desc = 'Next trouble entry' })
        vim.keymap.set("n", "]R", function() trouble.last({ skip_groups = true, jump = true }); end,
            { desc = 'Last trouble entry' })
    end,
}
