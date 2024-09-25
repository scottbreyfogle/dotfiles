local function config()
    local supermaven = require("supermaven-nvim")
    local cmp = require('cmp')
    local minuet = require('minuet')
    local copilot = require('copilot')

    supermaven.setup({
        disable_inline_completion = true,
        disable_keymaps = true,
    })

    copilot.setup({
        suggestion = {
            enabled = false,
        },
        panel = {
            enabled = false,
        },
        server_opts_overrides = {
            settings = {
                advanced = {
                    listCount = 2,
                }
            },
        }
    })
    require("copilot_cmp").setup()

    minuet.setup {
        provider = 'claude',
        add_single_line_entry = false,
        throttle = 0,
        debounce = 500,
        provider_options = {
            claude = {
                model = 'claude-3-5-sonnet-20240620',
                max_tokens = 1024,
            },
            openai = {
                model = 'gpt-4o-mini',
                -- model = 'gpt-3.5',
            },
        }
    }

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
            -- Still playing with these. Supermaven is much faster, but unclear of the quality.
            -- Minuet does not seem to play nice with other completion sources.
            { name = 'supermaven', priority = 60 },
            -- { name = 'copilot',    priority = 50 },
            { name = 'minuet',     priority = 40 },
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

    vim.keymap.set('n', '<leader>ai', function()
        require("supermaven-nvim.api").toggle()
        vim.cmd("Copilot toggle")
        vim.cmd("MinuetToggle")
    end, { desc = 'Toggle [ai] completion' });
end

return {
    'hrsh7th/nvim-cmp',
    priority = 200,
    config = config,
    dependencies = {
        'zbirenbaum/copilot-cmp',
        'zbirenbaum/copilot.lua',
        'milanglacier/minuet-ai.nvim',
        'supermaven-inc/supermaven-nvim',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        -- I don't currently use the snips, but cmp has some problems without them.
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip'
    },
}
