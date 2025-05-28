local function config()
    local cmp = require('cmp')
    local function key_mapping(mode)
        return {
            ['<tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    -- Select=true auto-selects the first entry, if nothing is selected
                    cmp.confirm({ select = true })
                else
                    fallback()
                end
            end, { mode }),
            ['<down>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { mode }),
            ['<up>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { mode }),
        }
    end

    cmp.setup {
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            end
        },
        mapping = key_mapping("i"),
        sources = {
            { name = 'path',       max_item_count = 10, priority = 100 },
            { name = 'nvim_lsp',   max_item_count = 10, priority = 90 },
            { name = 'buffer',     max_item_count = 5,  priority = 80 },
        },
        performance = {
            -- It is recommended to increase the timeout duration due to
            -- the typically slower response speed of LLMs compared to
            -- other completion sources. This is not needed when you only
            -- need manual completion.
            fetching_timeout = 5000,
        },
    }

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = key_mapping("c"),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = key_mapping("c"),
        sources = cmp.config.sources({
            -- This is the source for filepath completion. You can ask for it to add slashes
            -- (option.treat_trailing_slash=false), but then autocompletion won't be triggered on
            -- accepting the completion.
            { name = 'cmdline' }
        })
    })

    vim.opt.completeopt = 'menu,menuone,preview'
end

return {
    'hrsh7th/nvim-cmp',
    priority = 200,
    config = config,
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        -- I don't currently use the snips, but cmp has some problems without them.
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip'
    },
}
