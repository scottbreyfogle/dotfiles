return {
    'fholgado/minibufexpl.vim',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-unimpaired',
    'tpope/vim-rhubarb',
    'farmergreg/vim-lastplace',
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle)
        end
    },
    {
        'numToStr/Comment.nvim',
        opts = {},
    },

    -- TODO:
    -- lualine?
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects

    {
        'maxmx03/solarized.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = 'dark'
            vim.cmd.colorscheme 'solarized'
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            trouble = require("trouble")
            trouble.setup()
            vim.keymap.set("n", "<leader>t", function() trouble.toggle() end, { desc = '[T]rouble' })
            vim.keymap.set("n", "<leader>tw", function() trouble.toggle("workspace_diagnostics") end,
                { desc = '[T]rouble [W]orkspace Diagnoatics' })
            vim.keymap.set("n", "<leader>td", function() trouble.toggle("document_diagnostics") end,
                { desc = '[T]rouble [D]ocument Diagnostics' })
            vim.keymap.set("n", "<leader>tq", function() trouble.toggle("quickfix") end,
                { desc = '[T]rouble [Q]uickfix' })
            vim.keymap.set("n", "<leader>tl", function() trouble.toggle("loclist") end, { desc = '[T]rouble [L]oclist' })
            vim.keymap.set("n", "gr", function() require("trouble").toggle("lsp_references") end,
                { desc = '[G]o to [R]eferences (trouble)' })
        end,
    }
}
