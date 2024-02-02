local function config()
    local cmp = require 'cmp'

    local function key_mapping(mode)
        return {
            ['<tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
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
            { name = 'nvim_lsp', max_item_count = 10 },
            { name = 'buffer',   max_item_count = 5 },
            { name = 'path' },
        }
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
            { name = 'path' },
            { name = 'cmdline' }
        })
    })

    vim.api.nvim_create_user_command("DisableCmp", function()
        require("cmp").setup.buffer({ enabled = false })
    end, {})
    vim.api.nvim_create_user_command("EnableCmp", function()
        require("cmp").setup.buffer({ enabled = true })
    end, {})

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
