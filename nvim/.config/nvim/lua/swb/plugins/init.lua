return {
    'fholgado/minibufexpl.vim',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-unimpaired',
    'tpope/vim-rhubarb',
    'github/copilot.vim',

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
}
