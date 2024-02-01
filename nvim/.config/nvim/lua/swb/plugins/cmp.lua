function config()
    local cmp = require 'cmp'
    cmp.setup {
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            end
        },
        mapping = {
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            -- Use <enter> if the user has made a selection
            ['<CR>'] = cmp.mapping(function(fallback)
                if cmp.get_active_entry() then
                    cmp.confirm()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            -- But <tab> if it's the first default
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.confirm()
                else
                    fallback()
                end
            end, { 'i', 's' }),
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'path' },
        }
    }
    vim.opt.completeopt = 'menu,menuone,preview'

    vim.api.nvim_create_user_command("DisableCmp", function()
        require("cmp").setup.buffer({ enabled = false })
    end, {})
    vim.api.nvim_create_user_command("EnableCmp", function()
        require("cmp").setup.buffer({ enabled = true })
    end, {})
end

return {
    'hrsh7th/nvim-cmp',
    priority = 200,
    config = config,
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        -- I don't currently use the snips, but cmp has some problems without them.
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip'
    },
}
