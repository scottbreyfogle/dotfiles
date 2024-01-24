function config()
    local cmp = require 'cmp'
    cmp.setup {
        completion = {
            completeopt = 'menu,menuone,noinsert',
        },
        mapping = cmp.mapping.preset.insert {
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete {
                config = {
                    sources = {
                        { name = 'copilot' },
                    }
                }
            },
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
            { name = 'copilot' },
        },
    }
end

return {
    'hrsh7th/nvim-cmp',
    priority = 200,
    config = config,
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
    },
}
