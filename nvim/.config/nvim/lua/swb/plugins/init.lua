return {
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-unimpaired',
    'tpope/vim-rhubarb',
    -- Just for coerce to x_case mappings
    'tpope/vim-abolish',
    'farmergreg/vim-lastplace',
    {
        'fholgado/minibufexpl.vim',
        config = function()
            vim.keymap.set('n', '<leader>mb', vim.cmd.MBEToggle, { desc = 'Toggle [M]ini[B]uf Explorer' })
            vim.api.nvim_create_user_command('Bd', vim.cmd.MBEbd, {})
        end
    },
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle, { desc = 'Toggle [U]ndo [T]ree' })
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
        "ray-x/lsp_signature.nvim",
        config = function(_, opts)
            require('lsp_signature').setup({
                bind = true, -- This is mandatory, otherwise border config won't get registered.
                handler_opts = {
                    border = "rounded"
                }
            })
        end
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            trouble = require("trouble")
            trouble.setup()
            vim.keymap.set("n", "<leader>t", function() trouble.toggle("diagnostics") end, { desc = '[T]rouble' })
            vim.keymap.set("n", "<leader>tq", function() trouble.toggle("quickfix") end,
                { desc = '[T]rouble [Q]uickfix' })
            vim.keymap.set("n", "<leader>tl", function() trouble.toggle("loclist") end, { desc = '[T]rouble [L]oclist' })
            vim.keymap.set("n", "gr", function() require("trouble").toggle("lsp_references") end,
                { desc = '[G]o to [R]eferences (trouble)' })
            vim.keymap.set("n", "[R", function() require("trouble").first({ skip_groups = true, jump = true }); end,
                { desc = 'First trouble entry' })
            vim.keymap.set("n", "[r", function() require("trouble").previous({ skip_groups = true, jump = true }); end,
                { desc = 'Last trouble entry' })
            vim.keymap.set("n", "]r", function() require("trouble").next({ skip_groups = true, jump = true }); end,
                { desc = 'Next trouble entry' })
            vim.keymap.set("n", "]R", function() require("trouble").last({ skip_groups = true, jump = true }); end,
                { desc = 'Last trouble entry' })
        end,
    },
}
