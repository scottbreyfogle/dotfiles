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
}
