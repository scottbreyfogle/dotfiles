return {
    'fholgado/minibufexpl.vim',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-unimpaired',
    'tpope/vim-rhubarb',
    'github/copilot.vim',
    'sbdchd/neoformat',

    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'j-hui/fidget.nvim',

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
